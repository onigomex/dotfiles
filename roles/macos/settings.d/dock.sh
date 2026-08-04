#!/usr/bin/env zsh
set -e

# Desktop & Dock
# 単体実行: zsh roles/macos/settings.d/dock.sh
# - [x] Dock > Size: 35
# - [x] Dock > Magnification: Off
# - [x] Position on screen: Left
# - [x] Minimize window using: Genie Effect
# - [x] Double-click a window's title bar to: Zoom
# - [x] Automatically hide and show the Dock: true
# - [x] Animate opening applications: false
# - [x] Show indicators for open applications: false
# - [x] Show recent applications in Dock: false
# - [x] Dock から全てのアプリを削除（ゴミ箱だけにする）

## Dock > Size: 35
defaults write com.apple.dock tilesize -int 35
## Dock > Magnification: Off
defaults write com.apple.dock magnification -bool false
## Position on screen: Left
defaults write com.apple.dock orientation -string "left"
## Minimize window using: Genie Effect
defaults write com.apple.dock mineffect -string "genie"
## Double-click a window's title bar to: Zoom
defaults write -g AppleActionOnDoubleClick -string "Maximize"
## Automatically hide and show the Dock: true
defaults write com.apple.dock autohide -bool true
## Animate opening applications: false
defaults write com.apple.dock launchanim -bool false
## Show indicators for open applications: false
defaults write com.apple.dock show-process-indicators -bool false
## Show recent applications in Dock: false
defaults write com.apple.dock show-recents -bool false
## Dock から全てのアプリを削除（ゴミ箱だけにする）※以後は、起動中のアプリだけが Dock に表示される。
defaults write com.apple.dock persistent-apps -array
killall Dock
