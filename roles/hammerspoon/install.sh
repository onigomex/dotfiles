#!/usr/bin/env zsh
set -e

readonly CURRENT_PATH=$(cd $(dirname $0); pwd)
readonly SPOONS_DIR="${HOME}/.hammerspoon/Spoons"
readonly SPOONINSTALL_URL="https://github.com/Hammerspoon/Spoons/raw/master/Spoons/SpoonInstall.spoon.zip"


brew list --cask hammerspoon > /dev/null 2>&1 || {
  brew install hammerspoon --cask
}

(
cd ${CURRENT_PATH}
# .hammerspoon（init.lua と config/）を配布する。
cp -fr .hammerspoon ${HOME}
)

# Spoon の管理者である SpoonInstall だけは、それ自身を取得できないので install が入れる。
# 他の Spoon（Caffeine 等）は init.lua の SpoonInstall:andUse が実行時に取得する。
# 毎回 上流の最新に揃える（repo には同梱しない）。消えたファイルが残らないよう、
# SpoonInstall.spoon だけ削ってから展開する（Spoons ごと消すと他の Spoon を巻き添えにする）。
mkdir -p "${SPOONS_DIR}"
rm -rf "${SPOONS_DIR}/SpoonInstall.spoon"
curl -sL "${SPOONINSTALL_URL}" | /usr/bin/tar xz -C "${SPOONS_DIR}"

defaults write -app Terminal AppleLanguages "(en, ja)"

