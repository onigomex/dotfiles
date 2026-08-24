# roles/ghq
リポジトリを ~/src に整列して置く。repo コマンドの土台



## Dependencies
- homebrew
- git
- fzf



## Usage
```
ghq get <user>/<repo>  # ~/src/github.com/<user>/<repo> に clone
ghq list               # 管理下のリポジトリ一覧
ghq list --full-path
```
日常は `repo` コマンド（fzf で選んで cd）から使う。`ghq root` は `~/src`。



## References
- [x-motemen/ghq: Remote repository management made easy](https://github.com/x-motemen/ghq)

