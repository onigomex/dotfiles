#!/usr/bin/env zsh
set -e

readonly CURRENT_PATH=$(cd $(dirname $0); pwd)


brew list --cask ghostty > /dev/null 2>&1 || {
  brew install ghostty --cask
}

(
cd ${CURRENT_PATH}
cp -fr .config ${HOME}/
)
