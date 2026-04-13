# roles/pyenv
Python | pyenv/pyenv: Simple Python version management

- Python のバージョン管理ツール。
- 任意のバージョンをインストールでき、それらを切り替えて使用できる。



## Dependencies
- nothing



## Usage
```
% echo 'eval "$(pyenv init --path)"' >> ~/.zshrc
% brew install pyenv
% pyenv install --list | rg '\s[0-9].*' | tail
 3.9.7
 3.9.8
 3.9.9
 3.9.10
 3.10.0
 3.10-dev
 3.10.1
 3.10.2
 3.11.0a4
 3.11-dev

% pyenv install 3.10.2
% pyenv local 3.10.2
% python -V
Python 3.10.2
```

NOTE: README には、`eval "$(pyenv init -)"` とあるが、`eval "$(pyenv init --path)"` にしないとシステムデフォルトの Python を参照するため、こうしている。



## References
- [pyenv/pyenv: Simple Python version management](https://github.com/pyenv/pyenv)

