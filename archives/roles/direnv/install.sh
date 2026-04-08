#!/usr/bin/env zsh
set -e

readonly CURRENT_PATH=$(cd $(dirname $0); pwd)


brew list direnv > /dev/null 2>&1 || {
  brew install direnv
}

(
cd ${CURRENT_PATH}
cp -fr .zsh.d ${HOME}
)

