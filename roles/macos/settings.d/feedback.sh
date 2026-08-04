#!/usr/bin/env zsh
set -e

# Feedback
# 単体実行: zsh roles/macos/settings.d/feedback.sh
# - [x] クラッシュレポートを無効化する
# - [x] フィードバックを送信しない

## クラッシュレポート無効化
defaults write com.apple.CrashReporter DialogType -string "none"
## フィードバックを送信しない
defaults write com.apple.appleseed.FeedbackAssistant "Autogather" -bool false
