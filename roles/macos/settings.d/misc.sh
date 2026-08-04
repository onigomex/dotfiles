#!/usr/bin/env zsh
set -e

# Others（Battery / Security / .DS_Store など）
# 単体実行: zsh roles/macos/settings.d/misc.sh
# - [x] .DS_Store ファイルを作らせない（USB・ネットワークドライブ）
# - [x] 自動で頭文字を大文字にしない

# Battery
## バッテリーを%表示
# defaults write com.apple.menuextra.battery ShowPercent -string "YES"

# Security
## ファイアウォールon
# defaults write /Library/Preferences/com.Apple.alf globalstate -int 1

# Others
## 未確認ファイルを開く際の警告無効化
# defaults write com.apple.LaunchServices LSQuarantine -bool false
## .DS_Store ファイルを作成しない（ネットワークドライブ）
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
## .DS_Store ファイルを作成しない（USB ドライブ）
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
## 自動で頭文字を大文字にしない
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
## スペルの訂正を無効にする
# defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool "false"
## Googleのパブリック DNS を使用
# networksetup -setdnsservers Wi-Fi 2001:4860:4860::8844 2001:4860:4860::8888 8.8.4.4 8.8.8.8
