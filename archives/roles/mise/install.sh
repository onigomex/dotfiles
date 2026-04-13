#!/usr/bin/env zsh
set -e

readonly CURRENT_PATH=$(cd $(dirname $0); pwd)


brew list mise > /dev/null 2>&1 || {
  brew install mise
}

(
cd ${CURRENT_PATH}
cp -fr .zsh.d ${HOME}
)

