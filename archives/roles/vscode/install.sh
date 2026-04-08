#!/usr/bin/env zsh
set -e

readonly CURRENT_PATH=$(cd $(dirname $0); pwd)


brew list --cask visual-studio-code > /dev/null 2>&1 || {
  brew install visual-studio-code --cask
}

(
cd ${CURRENT_PATH}
cp -fr config/* "${HOME}/Library/Application Support/Code/User/"
)
