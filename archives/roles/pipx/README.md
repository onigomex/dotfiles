# roles/pipx
Python | pypa/pipx: Install and Run Python Applications in Isolated Environments

- poetry, mkdocs など、開発モジュールとは別管理したい Python 製の CLI ツールは、この pipx で管理すればスッキリする。
- pipx は、pip の拡張 CLI ツールで、使い方は、pip とほぼ同じ。
- インストールしたツール毎に独立した Python 環境（バージョン、依存モジュールなど）を保持できる。
- そのため、他のツールの Python 環境や、グローバル環境を気にせずに使える。



## Dependencies
- nothing



## Setup
※ install 時に設定するが、手動で行う場合は以下の通りにする。

```
% export XDG_DATA_HOME=$HOME/.config
% export PIPX_HOME=$XDG_DATA_HOME/pipx
% export PIPX_BIN_DIR=$HOME/bin
% export PATH=$PIPX_BIN_DIR:$PATH
% brew install pipx
```

NOTE: `pipx ensurepath` でも良いが、~/.zshrc などに自動的に PATH が書き込まれるため、自前で制御したければ上記のように設定する。



## Usage
pip と同じ `e.g. % pipx install poetry`



## References
- [pypa/pipx: Install and Run Python Applications in Isolated Environments](https://github.com/pypa/pipx/)

