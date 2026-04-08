# roles/uv
Python | An extremely fast Python package and project manager, written in Rust.

これ一つで開発に必要な一通りを行うことができる。

- Python インストール、バージョン管理
- Python アプリのインストール・実行（like pipx）
- pyproject.toml ベースの設定
- 仮想環境管理
- パッケージマネージャー



## Dependencies
- nothing



## Usage
### Init
```
% mkdir example; cd $_
% uv init .
% ll
total 12
drwxr-xr-x 6 h20240108 staff 192 Sep 12 16:48 .
drwxr-xr-x 3 h20240108 staff  96 Sep 12 16:47 ..
-rw-r--r-- 1 h20240108 staff   5 Sep 12 16:48 .python-version
-rw-r--r-- 1 h20240108 staff   0 Sep 12 16:48 README.md
-rw-r--r-- 1 h20240108 staff  85 Sep 12 16:48 hello.py
-rw-r--r-- 1 h20240108 staff 153 Sep 12 16:48 pyproject.toml
```


### Python インストール
```
% uv python install 3.10 3.11

# バージョン固定
% uv python pin 3.10
```


### 仮想環境作成
```
% uv venv
Using Python 3.10.15
Creating virtualenv at: .venv
Activate with: source .venv/bin/activate

# 仮想環境をアクティベート
% source .venv/bin/activate
% python -V
Python 3.10.15

# ディアクティベート
(example) % deactivate
```


### パッケージ導入
```
% uv add ruff
% uv pip list
Package Version
------- -------
ruff    0.6.4

% uv run ruff check
All checks passed!
```



## References
- [astral-sh/uv: An extremely fast Python package and project manager, written in Rust.](https://github.com/astral-sh/uv)

