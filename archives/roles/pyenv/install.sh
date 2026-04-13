#!/usr/bin/env zsh
set -e

readonly CURRENT_PATH=$(cd $(dirname $0); pwd)


brew list pyenv > /dev/null 2>&1 || {
  brew install pyenv
}

(
cd ${CURRENT_PATH}
cp -fr .zsh.d ${HOME}
cp -fr bin ${HOME}
chmod +x ${HOME}/bin/*
)

