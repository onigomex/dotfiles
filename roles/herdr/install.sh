#!/usr/bin/env zsh
set -e

readonly CURRENT_PATH=$(cd $(dirname $0); pwd)


brew list herdr > /dev/null 2>&1 || {
  brew install herdr
}

(
cd ${CURRENT_PATH}
cp -fr .config ${HOME}/
)
