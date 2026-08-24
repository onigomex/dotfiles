# roles/ripgrep
grep の代替。gitignore を尊重して速く全文検索する



## Dependencies
- homebrew
 


## Usage
```
rg <pattern>          # 再帰的に全文検索。gitignore は既定で尊重される
rg -t md <pattern>    # ファイル型で絞る
rg -uu <pattern>      # 無視設定も隠しファイルも全部含める
rg -l <pattern>       # ファイル名だけ
```
`fzf` の候補列挙にも使っている（`FZF_DEFAULT_COMMAND`）。



## References
- [BurntSushi/ripgrep: ripgrep recursively searches directories for a regex pattern while respecting your gitignore](https://github.com/BurntSushi/ripgrep)

