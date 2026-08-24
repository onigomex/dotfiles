# roles/fzf
あいまい検索の土台。repo / 履歴 / ファイル選択に使う



## Dependencies
- homebrew
- ripgrep



## Usage
あいまい検索そのものより、**他のコマンドの土台**として使うことが多い（`repo` / `todo l` / `gci` など）。

シェルのキーバインド:

```
Ctrl+T                # ファイルを選んでカーソル位置に挿入
Ctrl+R                # コマンド履歴をあいまい検索
Alt+C（macOS では ç）  # ディレクトリを選んで cd
```
候補の列挙は `rg --files --hidden`（`.git` / `.obsidian` / `.trash` を除外）。既定オプションは `.zsh.d/fzf.zshrc.env` にある。



## References
- [junegunn/fzf: A command-line fuzzy finder](https://github.com/junegunn/fzf)

