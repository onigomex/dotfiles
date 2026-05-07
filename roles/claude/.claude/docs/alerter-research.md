# Claude Code 通知に alerter を使った検証ノート

> 2026-05-07 検証。最終的に **osascript 版を採用**したが、alerter で得たノウハウを記録。

## 背景

- 環境: macOS / Ghostty / tmux / Claude Code (CLI)
- 要件: Claude Code の応答完了時に macOS の通知センター経由で通知を受け取る
- 当初: `osascript -e 'display notification …'` で十分動作
- 検討: 通知をクリックして Ghostty に戻れたら便利では？ → alerter を試した
- 結論: クリック復帰の便益 < 複雑性のコスト、と判断して osascript に戻した

## alerter とは

- macOS の通知センターに CLI から通知を送るツール
- terminal-notifier の事実上の後継（terminal-notifier は 2017 年 11 月で最終リリース停止）
- 作者: Valère Jeantet
- リポジトリ: <https://github.com/vjeantet/alerter>
- 要件: macOS 13 (Ventura) 以降
- Apple 署名・公証済み（Gatekeeper 警告なし）
- インストール: `brew install vjeantet/tap/alerter`

## 検証で得られた重要ノウハウ

### 1. Claude Code の hook 経由では `--sender` が効かない（要注意）

- `--sender com.example.foo` は通知のアイコンを偽装する機能
- ターミナル直接実行（インタラクティブシェル）では動作する
- **Claude Code の Bash 経由 / hook 経由では通知自体が抑止される**
- `nohup` + `disown` でプロセスをデタッチしても回避できなかった
- 推測される原因: macOS のセキュリティ制約（呼び出しプロセスの責任性 / TCC 周り）でバンドル ID 偽装の許可が下りない

#### 切り分け結果

| パターン | 結果 |
|---|---|
| `alerter` のみ（`--sender` なし）をターミナル直接 | ✅ 動作 |
| `alerter` のみ（`--sender` なし）を Claude Code Bash 経由 | ✅ 動作 |
| `alerter --sender com.mitchellh.ghostty` をターミナル直接 | ✅ 動作 |
| `alerter --sender com.mitchellh.ghostty` を Claude Code Bash 経由 | ❌ 通知出ない |
| 上記を `nohup`+`disown` でデタッチ | ❌ それでも出ない |

### 2. 回避策: クリック検知 + `open -a` でアプリ起動

- alerter の stdout から `@CONTENTCLICKED` / `@ACTIONCLICKED` を取得
- そこから `open -a Ghostty` で目的アプリを呼び出す
- ⚠️ 通知のアイコンは alerter のもの（Ghostty にはならない）

### 3. Hook 経由で alerter を呼ぶ正しいパターン

```bash
nohup bash -c '
  result=$(/opt/homebrew/bin/alerter --title "Claude Code" --message "応答が完了しました" --timeout 86400 --group claude-stop 2>/dev/null)
  case "$result" in
    @CONTENTCLICKED|@ACTIONCLICKED) /usr/bin/open -a Ghostty ;;
  esac
' >/dev/null 2>&1 &
disown
```

ポイント:
- **絶対パス必須** (`/opt/homebrew/bin/alerter`): Claude Code の hook 環境では `/opt/homebrew/bin` が PATH に含まれない
- **`nohup` + `disown`**: hook をブロックしない、alerter のクリック待ちが claude code を阻害しない
- **`--group <id>`**: 同一グループの古い alerter プロセスを新規通知到来時に置換（積み上がり防止）
- **`--timeout 86400`**: 24 時間以内のクリックを拾う（記事 [tech.every.tv](https://tech.every.tv/entry/2026/04/28/120000) のパターン踏襲）
- alerter プロセスは最大 24 時間バックグラウンドに残るが、`--group` のおかげで重複しない

### 4. alerter のクリック戻り値

| 戻り値 | 意味 |
|---|---|
| `@TIMEOUT` | `--timeout` で指定した秒数経過 |
| `@CLOSED` | 閉じるボタン押下 |
| `@CONTENTCLICKED` | 通知本体クリック |
| `@ACTIONCLICKED` | デフォルトアクション押下 |
| アクション名そのもの | `--actions` で定義したボタン押下 |

### 5. 主要オプション

| フラグ | 説明 |
|---|---|
| `--title <str>` | タイトル |
| `--subtitle <str>` | サブタイトル |
| `--message <str>` | 本文（必須または stdin パイプ） |
| `--sound <name>` | 通知音 (`Glass`, `Ping`, `Purr`, `Basso`, `default` 等) |
| `--timeout <sec>` | 自動タイムアウト秒 (デフォルト 0 = タイムアウトなし) |
| `--group <id>` | グループ ID（同 ID は新規通知で置換） |
| `--sender <bundle-id>` | 送信元アプリ偽装（hook 経由では効かない、要注意） |
| `--reply <text>` | 返信入力フィールド付き（`--actions` と排他） |
| `--actions <v1,v2,…>` | アクションボタン複数 |
| `--closeLabel <str>` | 閉じるボタンのラベル |
| `--json` | JSON 出力 |
| `--appIcon <path>` | カスタムアイコン（プライベート API 依存・将来非保証） |
| `--contentImage <path>` | コンテンツ画像（プライベート API 依存・将来非保証） |
| `--ignoreDnd` | おやすみモード無視（プライベート API 依存・将来非保証） |

## 採用したスクリプト最終形（参考）

`.claude/scripts/notify.sh`:

```bash
#!/usr/bin/env bash
# Claude Code notification helper.
#
# Usage: notify.sh <message> [sound] [group]
#
# Behavior:
#   - Skip if Ghostty is the frontmost app.
#   - Otherwise, fire alerter detached from the hook process.
#   - On click, bring Ghostty to the foreground.

set -u
MSG="${1:-Claude Code}"
SOUND="${2:-}"
GROUP="${3:-claude-default}"

front="$(/usr/bin/osascript -e 'tell application "System Events" to name of first application process whose frontmost is true' 2>/dev/null || true)"
if [ "$front" = "ghostty" ]; then
  exit 0
fi

export MSG SOUND GROUP

nohup bash -c '
  args=(--title "Claude Code" --message "$MSG" --group "$GROUP" --timeout 86400)
  if [ -n "$SOUND" ]; then
    args+=(--sound "$SOUND")
  fi
  result=$(/opt/homebrew/bin/alerter "${args[@]}" 2>/dev/null)
  case "$result" in
    @CONTENTCLICKED|@ACTIONCLICKED) /usr/bin/open -a Ghostty ;;
  esac
' >/dev/null 2>&1 &
disown
```

settings.json での hook 定義:

```json
"hooks": {
  "Stop": [{
    "matcher": "",
    "hooks": [{
      "type": "command",
      "command": "/path/to/.claude/scripts/notify.sh '応答が完了しました' '' claude-stop"
    }]
  }],
  "Notification": [{
    "matcher": "permission_prompt",
    "hooks": [{
      "type": "command",
      "command": "/path/to/.claude/scripts/notify.sh '承認待ちです' Glass claude-permission"
    }]
  }]
}
```

## 採用見送りの理由

1. **当初要件に対してオーバーキル**: 「応答完了で OS 通知が欲しい」だけなら osascript で完結
2. **クリック→Ghostty 復帰は ⌘ Tab で代替可能**: わざわざ通知をマウスでクリックする必然性が薄い
3. **依存・複雑性のコスト**: brew パッケージ、ヘルパースクリプト、長尺の hook 定義、PATH 依存
4. **dotfiles で共有・グローバル昇格を見据えると**、シンプルな方が他マシン展開も楽
5. **失うもの (`--group` 重複防止、`--actions` 等の将来拡張)** は、現時点で必要性なし

## 関連ツール状況（2026-05 時点・参考）

| ツール | 状態 | 備考 |
|---|---|---|
| **alerter** ([vjeantet/alerter](https://github.com/vjeantet/alerter)) | 🟢 アクティブ | 最終リリース 2026-02 (v26.5)、macOS 13+ |
| terminal-notifier ([julienXX/terminal-notifier](https://github.com/julienXX/terminal-notifier)) | 🟡 停滞 | 最終リリース 2017-11 (v2.0.0)、最終コミット 2021-08 |
| noti ([variadico/noti](https://github.com/variadico/noti)) | 🔴 archived | GitHub 上 archived、Codeberg に移行 |
| yo ([sheagcraig/yo](https://github.com/sheagcraig/yo)) | 🔴 停止 | 最終リリース 2019 |
| NotifiCLI ([saihgupr/NotifiCLI](https://github.com/saihgupr/NotifiCLI)) | 🟡 用途違い | クリック→アプリ起動非対応、URL のみ |

## 参考リンク

- [Claude Code を快適に使うための macOS デスクトップ通知セットアップ — every Tech Blog (ホーク🦅アイ👁️, 2026-04-28)](https://tech.every.tv/entry/2026/04/28/120000) — `nohup`+`disown` パターンの直接ヒント源
- [vjeantet/alerter (GitHub)](https://github.com/vjeantet/alerter) — alerter 一次情報
- [Claude Code Hooks Reference (公式)](https://code.claude.com/docs/en/hooks) — フック仕様
- [Claude Code Hooks Guide (公式)](https://code.claude.com/docs/en/hooks-guide)

## 将来再検討する条件

以下に該当したら alerter 復活を検討する余地あり:

- 通知に**操作ボタン（許可/却下など）を埋め込みたい** → `--actions` が必要
- 通知に**返信入力したい** → `--reply` が必要
- 通知の**重複が頻繁に問題になる** → `--group` が必要
- macOS が `display notification` のクリックハンドリングを将来サポートしたら不要になる
- `--sender` が Claude Code 経由でも動くようになったら、Ghostty アイコン表示も可能になる
