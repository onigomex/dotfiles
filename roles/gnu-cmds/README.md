# roles/gnu-cmds
GNU 版のコマンドを BSD 版より優先して使えるようにする



## Dependencies
- homebrew



## Usage
`coreutils` / `findutils` / `gnu-sed` / `gnu-tar` / `grep` を入れ、GNU 版の実体を `/usr/local/gnu/bin` に集めて PATH の前に置く。

```
sed -i 's/a/b/' file   # BSD 版のように '' を挟まなくてよい
date -d '1 day ago'    # BSD 版には無いオプションが使える
```
**BSD 版を明示したいときは `/usr/bin/sed` のように絶対パスで呼ぶ**（実際 `scripts/create.sh` はそうしている）。



## References
- [Software - GNU Project - Free Software Foundation](https://www.gnu.org/software/software.html)
- [List of GNU Core Utilities commands - Wikipedia](https://en.wikipedia.org/wiki/List_of_GNU_Core_Utilities_commands)

