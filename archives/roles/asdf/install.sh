#!/usr/bin/env zsh
set -e

readonly CURRENT_PATH=$(cd $(dirname $0); pwd)


brew list asdf > /dev/null 2>&1 || {
  brew install asdf
}

(
cd ${CURRENT_PATH}
cp -fr .zsh.d ${HOME}
)

