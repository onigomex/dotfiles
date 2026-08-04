#!/usr/bin/env zsh
set -e

# Finder
# 単体実行: zsh roles/macos/settings.d/finder.sh
# - [x] View > as List
# - [x] View > Show Path Bar
# - [x] View > Show Preview
# - [x] サイドバーのタグを非表示
# - [x] すべての拡張子を表示
# - [x] 隠しファイル・フォルダを表示
# - [x] ゴミ箱を空にするときの警告無効化
# - [x] パスバーを HOME から表示
# - [x] カレントディレクトリ内を検索
# - [x] 拡張子変更時の警告を無視

## View > as List: 常にリストビューにする（Nlsv:リスト, icnv:アイコン, clmv:カラム, Flwv:カバーフロー）
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
## タイトルバーにフルパスを表示
# defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
## パスバーを表示
defaults write com.apple.finder ShowPathbar -bool true
## ステータスバー表示
# defaults write com.apple.finder ShowStatusBar -bool true
## プレビューウィンドウを表示
defaults write com.apple.finder ShowPreviewPane -bool true
## サイドバーのタグを非表示
defaults write com.apple.finder ShowRecentTags -bool false
## すべての拡張子を表示
defaults write -g AppleShowAllExtensions -bool true
## 隠しファイル・フォルダを表示
defaults write com.apple.finder AppleShowAllFiles -bool true
## ゴミ箱を空にするときの警告無効化
defaults write com.apple.finder WarnOnEmptyTrash -bool false
## パスパーを HOME から表示
defaults write com.apple.finder PathBarRootAtHome -bool true
## カレントディレクトリ内を検索
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
## 拡張子変更時の警告を無視
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
killall Finder
