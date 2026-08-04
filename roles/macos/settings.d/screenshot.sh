#!/usr/bin/env zsh
set -e

# Screen Shot
# 単体実行: zsh roles/macos/settings.d/screenshot.sh
# - [x] スクリーンショット保存先を変更
# - [x] スクリーンショット名を日付だけにする

## 画像の影を無効化
# defaults write com.apple.screencapture "disable-shadow" -bool true
## 撮影時のサムネイル表示
# defaults write com.apple.screencapture "show-thumbnail" -bool false
## スクリーンショットを jpg で保存
# defaults write com.apple.screencapture type -string "jpg"
## スクリーンショット保存先を変更
_screenshotdir=$HOME/Desktop/_ScreenShot
mkdir -p $_screenshotdir
defaults write com.apple.screencapture location -string "$_screenshotdir"
## スクリーンショット名を日付だけにする
defaults write com.apple.screencapture name ""
killall SystemUIServer
