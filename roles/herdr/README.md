# roles/herdr
AI エージェントの状態表示ウィンドウを標準搭載したターミナルマルチプレクサ。tmux 代替。



## Dependencies
- homebrew



## Usage
```
% herdr
```
- tmux とプレフィックスは同じ
- Prefix + w: 主要なキーバインドを表示
- Prefix + ?: キーバインド一覧
- 設定ファイル: https://herdr.dev/ja/docs/configuration/



## テーマのカスタマイズ (`[theme.custom]`)
ベーステーマ（`nord` 等）の上に、個別トークンを上書きできる。値は hex / 名前付き色 / `rgb(r,g,b)` / `reset` などのリセット別名。設定後は `herdr server reload-config` で反映（再起動不要）。

各トークンが UI のどこに効くかを、単体で色を変えて実測した結果（herdr 0.7.4 / テーマ nord）:

| キー | 種別 | 効果 |
|---|---|---|
| `text` | 前景 | サイドバー項目のテキスト（上段 spaces・下段 agents 両方、tradingview 等の名前） |
| `subtext0` | 前景 | 変化なし（現行レイアウトでは未使用） |
| `panel_bg` | 背景 | タブの背景 ＋ ポップアップ（TUI ダイアログ）の背景 |
| `surface0` | 背景 | 非選択タブの背景 |
| `surface1` | 背景 | 変化なし |
| `surface_dim` | 背景/線 | サイドバー各行の背景 ＋ サイドバーの囲み線 |
| `overlay0` | 前景/線 | サイドバーのラベル文字（spaces / new menu / agents / grouped）＋ 稼働中エージェント名（claude）＋ 非選択ペインの枠線 |
| `overlay1` | 前景 | タブ追加の「+」ボタン |
| `accent` | 線/前景 | 選択中ペインの枠線 ＋ ペインのタイトル文字 |
| `mauve` | 前景 | サイドバー上段のブランチ名（main） |
| `green` | 状態色 | ステータスマーク：待機・完了（○ / ✓） |
| `yellow` | 状態色 | ステータスマーク：処理中（更新中） |
| `red` | 状態色 | エラー系と推測（該当状態を再現できず未確認） |
| `blue` | 状態色 | 変化なし |
| `teal` | 状態色 | 変化なし |
| `peach` | 状態色 | 変化なし |

### 補足
- エージェント名の色は状態で異なる。非稼働（tradingview）は `text`、稼働中（claude）は `overlay0` で描画される（推測。内部仕様は未確認）。
- そのため「稼働中エージェント名の文字色」だけを単独で変えることはできず、`overlay0` を変えるとサイドバーのラベル文字群と非選択ペインの枠線も同時に変わる。
- サイドバー専用・エージェント名専用の色キーは公式リファレンスに存在しない（[Config reference](https://herdr.dev/docs/config-reference/)）。

### 現在の適用値
```toml
[theme.custom]
overlay0    = "#6b7a94"  # サイドバーのラベル文字＋未選択ペイン枠（落ち着いた中間トーン）
surface_dim = "#4c566a"  # nord3: サイドバーの区切り線・枠線を可視化
```



## キーバインドのカスタマイズ (`[keys]`)
`アクション名 = "キー文字列"` で割り当てる。複数割当は配列。既定を残して追加したい場合も配列にする。設定後は `herdr server reload-config` で反映（`diagnostics` に無効な割当が出る）。

- プレフィックスは既定 `ctrl+b`（tmux と同じ）。
- 記法：`prefix+o`（プレフィックス→o）、`ctrl+alt+n`（直接）。修飾子は `ctrl` `shift` `alt` `cmd`。
- 全アクションと既定値は `herdr --default-config` の `[keys]` セクション、または稼働中は `prefix+?` で確認。

### 記号キーのトークン名（herdr 0.7.4 実測）
公式が明示するのは `minus` `comma` `ampersand` `plus` `backtick` のみだが、実測で以下も判明。無効な割当は reload 時に `invalid keybinding ...; disabling binding` と出る。

| 記号 | トークン | 可否 |
|---|---|---|
| `%` | `percent` | ✅ 有効 |
| `'` | `quote` | ✅ 有効（`'` を指す。`"` ではない） |
| `"` | `doublequote` | ❌ 無効（トークン自体が不可） |
| `"` | `shift+quote` | △ トークンは有効だが**動作せず**（後述） |
| `;` | `semicolon` | ✅ 有効 |

- **`"`（tmux の上下分割キー）はこの環境では使えない。** herdr 既定コメントに「punctuation-with-modifiers（記号＋修飾キー）はターミナル/tmux 設定に依存」とあり、`shift+quote` はトークンとして有効でもキー入力が届かない。代わりに修飾なしの `'`（`quote`）を採用した。

### tmux に合わせた割当（実運用）
方向移動 `prefix+h/j/k/l` は herdr 既定と tmux（自分の `.tmux.conf`）が既に一致。差分のあるものだけ追加した。

```toml
[keys]
split_vertical   = ["prefix+v", "prefix+percent"]      # 左右分割：既定 + tmux %
split_horizontal = ["prefix+minus", "prefix+quote"]    # 上下分割：既定 + '（tmux の " は端末依存で不可）
cycle_pane_next  = ["prefix+tab", "prefix+o"]          # 次のペイン：既定 + tmux o
last_pane        = "prefix+semicolon"                  # 直前のペイン：tmux ;（既定は未設定）
```



## 作業開始を 1 キーにまとめる（`herdr-claude-workspace` / `prefix+c`）

いつもの手順（新規ワークスペース → `repo` でリポジトリ選択 → `claude` 起動 → `hello` と入力 → ペイン分割 → 右にターミナル）を 1 アクションに畳んだもの。

```
prefix+c                          # herdr 上（一時ペインで fzf が開く）
herdr-claude-workspace [prompt]   # 素のターミナルから
```

やること:

1. `ghq list` を fzf で選ばせる（UI は `repo` コマンドと同じ）
2. そのリポジトリを cwd にワークスペースを作成（ラベルはディレクトリ名が自動で付く）
3. 右に 50% でターミナルを分割
4. 左で claude を起動し、最初のプロンプト（既定 `hello`）を送信してフォーカス

`hello` に意味は無くてよい。SessionStart フックが TODO を差し込むので、claude 側は「挨拶されたので TODO を要約して次を訊く」という素直な反応をする。具体的な指示を書くとその言い回しがセッションの方向づけになるため、あえて無味な起点にしている。引数で上書きできる。

### 実装メモ
- herdr の socket API（`herdr workspace create` / `pane split` / `agent start` / `agent prompt` / `agent focus`）を叩いているだけ。出力は JSON なので `jq` で `pane_id` を拾う。
- 短い alias（`c`）は付けない。日常の入口は `prefix+c` で、コマンドを直に打つのは稀。名前を忘れたら `help` に載っている。
- `herdr agent start` は herdr が claude を対話状態と見なすまで待ってから返るので、`sleep` で起動を待つ必要は無い。ただし**それは次の入力が受け取られる保証ではない**。claude は起動直後の数秒（バナーや `Update available!` の描画中）に入力を取りこぼすことがあり、エラーも出ないまま入力欄が空のままになる。実機で 2 度踏んだ。
- そのため最初のプロンプトは `agent prompt --wait --until working` で送る。`--wait` は送信後に状態変化を観測してから返るので、取りこぼしがタイムアウトとして露見する。失敗したら再送する（最大 3 回）。取りこぼしは何も残さないので再送しても二重入力にならない。
- 既に同じリポジトリのワークスペースがある場合は、新規作成せずそれにフォーカスする（同じチェックアウトを二重に開くと、どちらで作業したか分からなくなる）。同じリポジトリを並行して開きたいときは git worktree を作ってそちらを開く。
- `prefix+c` は素の `new_workspace` から明け渡した。リポジトリも claude も無い空のワークスペースを開きたい場面が実際には無かったので、よく使うほうを押しやすいキーに置いた。素のワークスペースが要るときは herdr 既定の `prefix+shift+n`。
- **キー割当は `type = "pane"`（レイアウト内の一時ペイン）。`type = "popup"` は使えない。** popup はセッションモーダルで寿命がフォーカスに左右され、セットアップの途中でプロセスごと落ちる。実際に「ペインは 2 つあるが claude がいない」「claude は起動したが最初のプロンプトが届かない」を踏んだ。一時ペインなら寿命がコマンドに紐づく。なお `type = "pane"` は `width` / `height` を受け付けない（reload が `popup size on non-popup custom command` を返す）。
- **セットアップが終わるまでフォーカスを動かさない。** 作成も分割も `--no-focus` で行い、フォーカスは最後にまとめて移す。フォーカス変更はこのスクリプトが動いている端末を畳んでしまうことがある。
- **`herdr agent start` に渡すエージェント名はセッション内で一意でなければならない**（重複すると `agent_name_taken`）。`claude` 決め打ちだと 2 つ目で失敗するので、リポジトリ名を使う。
- 一時ペインのタイトルは端末が報告する OSC 0 タイトルで付けている。`[[keys.command]]` に title 相当のキーは無い（`title` / `label` / `name` を試すと reload が `unknown config key` を返す）。
- コマンドが `zsh -ic`（対話シェル）なのは PATH のため。この環境の zsh 起動ファイルは `~/.zshrc` だけで `~/.zshenv` も `~/.zprofile` も無く、zsh は `.zshrc` を対話シェルでしか読まないので、`-lc`（ログイン・非対話）では `~/bin` に PATH が通らない。



## References
- https://github.com/ogulcancelik/herdr

