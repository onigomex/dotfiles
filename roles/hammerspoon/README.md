# roles/hammerspoon
Hammerspoon（Lua による macOS デスクトップ自動化）を導入し、設定（`.hammerspoon/`）を配布する role。

## 依存
- homebrew

## 環境設定（Preferences > Behavior）
Hammerspoon 環境設定の Behavior パネルは、`init.lua` で Lua API により宣言的に設定している（起動の度に実行＝冪等・まっさらな Mac でも再現）。

| 項目 | 状態 | コード（init.lua） |
|---|---|---|
| Launch Hammerspoon at login | ON | `hs.autoLaunch(true)` |
| Check for updates | ON | `hs.automaticallyCheckForUpdates(true)` |
| Show dock icon | OFF | `hs.dockIcon(false)` |
| Show menu icon | ON | `hs.menuIcon(true)` |
| Keep Console window on top | OFF | `hs.consoleOnTop(false)` |
| Send crash data | OFF | `hs.uploadCrashData(false)` |

## プラグイン（Spoons）
Hammerspoon のプラグインは **Spoon** と呼ばれる形式（`~/.hammerspoon/Spoons/*.spoon`）。この role では Spoon を **SpoonInstall** で宣言的に管理する。

- **SpoonInstall とは**: Spoon をインストール／管理するための Spoon（作者 Diego Zamboni・MIT）。Hammerspoon 本体には Spoon のパッケージ管理機構が無く、その空白を埋める事実上の標準。公式リポジトリ `Hammerspoon/Spoons` に同梱され、公式 Spoons ページにも掲載される（コミュニティ製だが公式配布）。
- **管理方式**: `SpoonInstall.spoon` だけを repo に同梱（vendor）し、`Spoons/.gitignore` で他の Spoon は追跡しない。各 Spoon は `init.lua` で `spoon.SpoonInstall:andUse("Name", {…})` と宣言すると、公式リポジトリから自動取得＋設定＋hotkey＋起動まで一括で行われる。Spoon を増やすのは `andUse` を1行足すだけで、`install.sh` は触らない。

### Caffeine（スリープ防止）
Mac の自動スリープ（ディスプレイ／システム）を抑止する Spoon。SpoonInstall の `andUse` で導入し、起動時にオンにする。メニューバーのアイコン、または hyper+F6 でトグルできる。

## Accessibility（コード化不可・手動）
`System Settings > Privacy & Security > Accessibility` で Hammerspoon を**手動で ON** にする必要がある。イベントタップ（En/Ja 切替やホットキー）に必須。

- **なぜコードで ON にできないか**: Accessibility 許可は macOS の TCC（透明性・同意・制御）が管理し、その許可 DB は SIP で保護されている。そのため `defaults` や CLI からの付与はできず（`tccutil` で可能なのは取り消し=reset のみ）、付与にはユーザーの明示的なダイアログ承認が必要。MDM の PPPC プロファイルなら付与可能だが、個人（非 MDM）の Mac では手動が唯一の手段。
- 補足: `init.lua` で `hs.accessibilityState(true)` を呼ぶと許可ダイアログを prompt できるが、最終的な「許可」クリックは手動。

## 手動セットアップ手順（残る手作業）
1. 初回起動後、`System Settings > Privacy & Security > Accessibility` で Hammerspoon を ON にする（上記の理由によりコード化不可）。

## References
- [Hammerspoon/hammerspoon: Staggeringly powerful macOS desktop automation with Lua](https://github.com/Hammerspoon/hammerspoon)
- [Hammerspoon docs（hs モジュール: autoLaunch / automaticallyCheckForUpdates / dockIcon / menuIcon / consoleOnTop / uploadCrashData / accessibilityState）](https://www.hammerspoon.org/docs/hs.html)
- [Hammerspoon Spoons（プラグイン一覧）](https://www.hammerspoon.org/Spoons/)
- [SpoonInstall（Spoon の宣言的管理・de-facto 標準）](https://www.hammerspoon.org/Spoons/SpoonInstall.html)
- [zzamboni: Using Spoons in Hammerspoon](https://zzamboni.org/post/using-spoons-in-hammerspoon/)
- [Caffeine.spoon](https://www.hammerspoon.org/Spoons/Caffeine.html)
- [Hammerspoon FAQ（Accessibility 権限まわり）](https://www.hammerspoon.org/faq/)
