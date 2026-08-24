# roles/google-japanese-ime
日本語入力。macOS 標準の IME の代わりに使う



## Dependencies
- homebrew



## Settings
System Settings > Keyboard > Text Input > Input Sources > Edit

- Alphanumeric(Google)
- Hiragana(Google)
- [x] Show Input menu in menu bar
- [ ] Automatically switch to a document's input source


### Input Source を Google 日本語入力のみにする方法
1. ことえり > Japanese - Romaji を選択
1. Input modes > Romaji にチェックする。
1. そうすると ABC が消せる。その後に Romaji も削除すると、Google 日本語入力のみにできる。

![](https://raw.githubusercontent.com/onigomex/dotfiles/images/roles/google-japanese-ime/ScreenShot-01.png)



## Usage
GUI（入力ソース）。英数と日本語の切り替えは Hammerspoon 側で割り当てている。

**手動で必要なこと**: `System Settings > Keyboard > Input Sources` への追加と、標準 IME の削除。反映には再ログインが必要なことがある。



## References
- [Google 日本語入力 – Google](https://www.google.co.jp/ime/)
- [Macの入力ソースからUSを消す方法 - NISHI3’s blog](https://nishi3.hatenablog.com/entry/2018/01/18/161745)

