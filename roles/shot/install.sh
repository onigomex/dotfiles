#!/usr/bin/env zsh
set -e

readonly CURRENT_PATH=$(cd $(dirname $0); pwd)

# fzf のプレビューで画像を出すのに、kitty に付いてくる kitten を使う
brew list --cask kitty > /dev/null 2>&1 || {
  brew install --cask kitty
}

(
cd ${CURRENT_PATH}
cp -fr bin ${HOME}
chmod +x ${HOME}/bin/*
)
