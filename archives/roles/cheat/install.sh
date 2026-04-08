#!/usr/bin/env zsh
set -e

readonly CURRENT_PATH=$(cd $(dirname $0); pwd)


brew list cheat > /dev/null 2>&1 || {
  brew install --HEAD onigomex/apps/cheat
}

(
cd ${CURRENT_PATH}
cp -fr .zsh.d ${HOME}
)

