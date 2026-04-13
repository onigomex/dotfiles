# roles/poetry
Python | python-poetry/poetry: Python dependency management and packaging made easy.

- プロジェクトの作成、パッケージ管理、ビルド、PyPI へのデプロイが、このツールだけで実施できる。
- 類似ツール: Pipenv、Pyflow



## Dependencies
- pipx
- pyenv, asdf などバージョン管理ツール



## Usage
### Install poetry
```
% pipx install poetry
% poetry config virtualenvs.in-project true
% poetry config --list
cache-dir = "/Users/xxxxxxxxx/Library/Caches/pypoetry"
experimental.new-installer = true
installer.parallel = true
virtualenvs.create = true
virtualenvs.in-project = true
virtualenvs.path = "{cache-dir}/virtualenvs"  # /Users/xxxxxxxxx/Library/Caches/pypoetry/virtualenvs
% rm -rf /Users/xxxxxxxxx/Library/Caches/pypoetry/virtualenvs
```

- virtualenvs.in-project = true: poetry が作成する仮想環境（.venv フォルダ）をプロジェクト直下に作成する。
- デフォルトは、virtualenvs.path 直下に作成される。わかり易さと、VSCode の PATH 対応のため、上記に変更する。
- virtualenvs.in-project = true に設定しても、既に virtualenvs.path 配下に仮想環境が作成されていた場合はそれを参照するためディレクトリごと削除する。


### Setup Development env
```
% pyenv install 3.10.2
% poetry new example; cd $_;
Created package example in example
% pyenv local 3.10.2
% python -V
Python 3.10.2
% poetry add flake8 mypy black isort -D
```



## References
- [python-poetry/poetry: Python dependency management and packaging made easy.](https://github.com/python-poetry/poetry)

