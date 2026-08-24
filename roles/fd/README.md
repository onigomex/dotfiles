# roles/fd
find の代替。速く、gitignore を尊重して探す



## Dependencies
- homebrew



## Usage
```
fd <pattern>          # 名前で探す。gitignore は既定で尊重される
fd -e md              # 拡張子で絞る
fd -H                 # 隠しファイルも含める
fd -t d <pattern>     # ディレクトリだけ
```



## References
- [sharkdp/fd: A simple, fast and user-friendly alternative to 'find'](https://github.com/sharkdp/fd)

