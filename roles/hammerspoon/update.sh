#!/usr/bin/env zsh
set -e

# roles/hammerspoon の update フック（make update ROLE=hammerspoon から実行）。
# vendored な SpoonInstall.spoon を公式 Spoons リポジトリの最新で上書きする。
# 実行後、git diff が空なら最新、差分があれば更新あり（レビューしてコミット＝版 bump）。
# 参照: docs/adr/0002-per-role-update-hook.md

readonly CURRENT_PATH=$(cd $(dirname $0); pwd)
readonly SPOONS_DIR="${CURRENT_PATH}/.hammerspoon/Spoons"
readonly ZIP_URL="https://github.com/Hammerspoon/Spoons/raw/master/Spoons/SpoonInstall.spoon.zip"

echo "[INFO] Refreshing vendored SpoonInstall.spoon from ${ZIP_URL}"
curl -sL "${ZIP_URL}" | /usr/bin/tar xz -C "${SPOONS_DIR}"
echo "[INFO] Done. 'git diff roles/hammerspoon/.hammerspoon/Spoons/SpoonInstall.spoon' が空なら最新、差分があれば更新（レビューしてコミット）。"
