# roles/rye
Python | a Hassle-Free Python Experience

これ一つで開発に必要な一通りを行うことができる。

- Python インストール、バージョン管理
- Python アプリのインストール・実行（like pipx）
- pyproject.toml ベースの設定
- 仮想環境管理
- パッケージマネージャー
- test(pytest), fmt, lint(ruff) など開発時に必要なツールが同梱されている。
- publish（世にリリース）

NOTE:
- いずれ uv に吸収される方向のようだが、2024/09/12 時点ではまだ追いついていない。
- そのため、しばらくは rye を使い、uv が成熟したら乗り換えるのが良いだろう。
- uv 単体でもだいたい同じことができるが、仮想環境に手動で入らなければならない、インストールが手動など、まだ rye のほうが便利な場面が多い。
- rye のパッケージマネージャーに、uv が同梱されるようになったため、uv の便利な部分はすでに使用できるようになっている。



## Dependencies
- nothing



## Usage
### Init
```
% mkdir example; cd $_
% rye init .
% tree -a
.
├── .git
│   ├── HEAD
│   ├── config
│   ├── hooks
│   │   ├── commit-msg
│   │   ├── pre-commit
│   │   └── prepare-commit-msg
│   ├── objects
│   │   ├── info
│   │   └── pack
│   └── refs
│       ├── heads
│       └── tags
├── .gitignore
├── .python-version
├── README.md
├── pyproject.toml
└── src
    └── example
        └── __init__.py

11 directories, 10 files

# init 時点で自動的に python パスが変更される。
% which python
/Users/h20240108/.rye/shims/python
```


### 仮想環境作成
※  sync することで自動的に .venv が作成される。それ以降は rye が透過的に仮想環境を管理するため、特に気にする必要がない。

```
# 仮想環境作成だけでなく必要なことはすべて sync するだけで実施される。
% rye sync
```


### Python インストール
```
# バージョン固定
% rye python pin 3.10

# インストール（Pin したバージョンを初回使用時に無ければ自動でインストールする）
% python -V
Python 3.10.14
```


### パッケージ導入
```
% rye add ruff
% rye list
-e file:///Users/h20240108/_work/2024-09-12_python-rye/example
ruff==0.6.4

% rye run ruff check
All checks passed!
```



## References
- [astral-sh/rye: a Hassle-Free Python Experience](https://github.com/astral-sh/rye?tab=readme-ov-file)
- [Rye × uvでPython環境と機械学習環境を整える](https://zenn.dev/turing_motors/articles/0f1a764d14f581)

