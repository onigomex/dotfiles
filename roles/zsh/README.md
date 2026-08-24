# roles/zsh
ログインシェル本体と、.zshrc / .zsh.d の土台



## Dependencies
- homebrew
- git
- ghq
- gnu-cmds



## Usage
ログインシェル本体。

```
ll                    # ls -la
precmd-on             # プロンプトにブランチとパスを出す
precmd-off            # 止める
```
**ロールから zsh 設定を配る規約は [docs/zsh-config.md](../../docs/zsh-config.md) が正**（置き場所・命名・読み込み順・落とし穴）。



## References
- [zsh-users/zsh: Mirror of the Z shell source code repository.](https://github.com/zsh-users/zsh)
- [zshの設定ファイルの読み込み順序と使い方Tipsまとめ - Qiita](https://qiita.com/muran001/items/7b104d33f5ea3f75353f)
- [zshの起動が遅いのでなんとかしたい - Qiita](https://qiita.com/vintersnow/items/7343b9bf60ea468a4180)
- [俺的爆速zshrc/zprofile - おのかちお's blog](https://blog.katio.net/page/2ffdedfbeb0867ac6b55)

