#!/usr/bin/env zsh
set -e

readonly CURRENT_PATH=$(cd $(dirname $0); pwd)


# Python 管理は uv に一本化する（pyenv/pip/venv/pipx 相当を 1 ツールで担う）。
# 将来 uv を置き換えるツールが出たら、この role の中身を差し替える。
brew list uv > /dev/null 2>&1 || {
  brew install uv
}

# デフォルトの Python として最新版を導入し、python / python3 も張る（--default）。
# uv 側で冪等（既に管理下の最新があれば再ダウンロードしない）。
# 特定バージョンが要るときは別途 `uv python install <version>` を手動で行う。
uv python install --default

(
cd ${CURRENT_PATH}
cp -fr .zsh.d ${HOME}/
)
