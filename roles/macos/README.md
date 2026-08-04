# roles/macos

macOS のシステム設定（GUI/System Settings 相当）を `defaults` 等で適用する role。



## Dependencies
- nothing



## 構成
設定は「関心ごと」で `settings.d/*.sh` に分割している。`install.sh` はそれらを
名前順に `source` するだけの薄いランナー。

```
roles/macos/
├── install.sh          # 薄いランナー（settings.d/*.sh を名前順に source）
├── settings.d/         # 関心ごとに1ファイル・各自完結・冪等
│   ├── dock.sh         # Desktop & Dock
│   ├── desktop-view.sh # Desktop > Show View Options
│   ├── finder.sh       # Finder
│   ├── keyboard.sh     # Keyboard（Caps Lock→Control / F キー）
│   ├── spotlight.sh    # Siri & Spotlight
│   ├── screenshot.sh   # Screen Shot
│   ├── feedback.sh     # Crash Report / Feedback
│   ├── terminal.sh     # Terminal.app プロファイル
│   └── misc.sh         # .DS_Store / 大文字自動化 など
└── README.md
```

- **各パーツは自己完結**: 対象アプリの `killall` まで含み、単体で
  `zsh roles/macos/settings.d/finder.sh` を実行しても成立する（＝壊れた箇所を局所化して検証できる）。
- **追加/削除**: `settings.d/` にファイルを置く/消すだけ。`install.sh` は触らない。
- 各設定の項目（チェックリスト）は、対応するパーツ先頭のコメントに記載している。



## Tips
### 設定を参照する
```
# e.g., Finder
% defaults read com.apple.finder
```


### 設定をリセットする
```
# e.g., Finder
% rm ~/Library/Preferences/com.apple.finder.plist
% killall Finder
```


### 変更した GUI 設定をコードに起こす（キャプチャ）
GUI で設定 → 変化した plist を差分で特定 → `defaults write` に落とす。
```
% defaults export <domain> before.plist   # 変更前
# … System Settings で変更 …
% defaults export <domain> after.plist    # 変更後
% diff <(plutil -p before.plist) <(plutil -p after.plist)
```



## References
- [macOSでの各種設定を自動化するdefaultsコマンド - memo.yammer.jp](https://memo.yammer.jp/posts/macos-defaults)
- [MacOS　PlistBuddyコマンドを使ってplistファイルを自由に編集しよう #MacOSX - Qiita](https://qiita.com/keitean/items/6972b8f34636a88bae74)
- [初めての Apple Script #AppleScript - Qiita](https://qiita.com/satosystems/items/8fff5b2313ecd6f81af3)
- [コマンドラインから macOS をコントロールする - talkabout](https://talkabout.jp/smarthome/macos-teminal.html)
- [osascriptでOS Xのアプリを操作する - Bye Bye Moore](https://shuzo-kino.hateblo.jp/entry/2015/01/03/234722)
- [Apple Script で CLI を作るための要点](https://zenn.dev/suzuki_hoge/articles/2020-12-apple-script-984ae31d9a473ca1ffb2)
- [macOS defaults list](https://macos-defaults.com/)
- [Mac ターミナル defaults コマンドの使い方](https://www.webdesignleaves.com/pr/plugins/mac_terminal_basics_06.html)
- [1からMacの開発環境を構築する](https://zenn.dev/horatjp/articles/macos-dev-env)
- [Macの設定の半自動化方法 #Mac - Qiita](https://qiita.com/DiveMasakazu/items/ac4c6daad50084656758)
- [What is PlistBuddy?. PlistBuddy is mac build-in program… | by Mark | Medium](https://medium.com/@marksiu/what-is-plistbuddy-76cb4f0c262d)
- [システム環境設定の表示操作：Macはからだの一部です。：SSブログ](https://start-mac.blog.ss-blog.jp/2020-08-04)
- [dotfiles/.macos at master · cbracco/dotfiles](https://github.com/cbracco/dotfiles/blob/master/.macos)
