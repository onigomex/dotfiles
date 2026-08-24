# roles/tig
git のログと差分を TUI で追う



## Dependencies
- homebrew
- git
- gh



## Usage
```
tig                   # ログを追う。Enter で差分、q で戻る
tig status            # git status の TUI 版。ここから add できる
tig blame <file>      # 行ごとの由来
```



## References
- [jonas/tig: Text-mode interface for git](https://github.com/jonas/tig)

