#!/usr/bin/env zsh
set -e

readonly CURRENT_PATH=$(cd $(dirname $0); pwd)


brew list --cask hammerspoon > /dev/null 2>&1 || {
  brew install hammerspoon --cask
}

(
cd ${CURRENT_PATH}
# .hammerspoon（config/ と Spoons/SpoonInstall.spoon を含む）を配布する。
# 他の Spoon（Caffeine 等）は init.lua の SpoonInstall:andUse が実行時に取得する。
cp -fr .hammerspoon ${HOME}
)

defaults write -app Terminal AppleLanguages "(en, ja)"

