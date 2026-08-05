#!/usr/bin/env zsh
set -e

# Siri & Spotlight
# 単体実行: zsh roles/macos/settings.d/spotlight.sh
# - [x] 「Apple の検索機能の改善に協力」: OFF
# - [x] 検索結果: Applications / Folders / 計算機 / 辞書 を ON（他カテゴリ＋アプリからの結果は OFF）
# - [x] Spotlight 内のクリップボード履歴: OFF（クリップボード管理は Maccy を使うため）
#
# ※ macOS 26 Tahoe の実測キャプチャ由来（EnabledPreferenceRules は非公開スキーマ）。
#    GUI で全カテゴリを ON にした状態（＝空配列）をベースラインに、理想形との差分で
#    「OFF にした源の配列」を確定した（2026-08-04）。ラウンドトリップ検証で再現性を確認済み。
#    OS メジャー更新でスキーマが変わったら要再キャプチャ（取得手順は README の「キャプチャ」参照）。

## 「Apple の検索機能の改善に協力」OFF（2 = opt-out）
defaults write com.apple.assistant.support "Search Queries Data Sharing Status" -int 2

## 検索結果: Applications / Folders / 計算機 / 辞書 を ON
## （下記に列挙した源が OFF になる。全 ON = 空配列。-array で置換＝冪等）
## ※ 計算機(com.apple.calculator)・辞書(com.apple.Dictionary) は配列から外して ON に戻した
defaults write com.apple.Spotlight EnabledPreferenceRules -array \
  "Custom.relatedContents" \
  "System.iphoneApps" \
  "System.files" \
  "System.menuItems" \
  "com.apple.AppStore" \
  "com.apple.Safari" \
  "com.apple.iCal" \
  "com.apple.systempreferences" \
  "com.apple.shortcuts" \
  "com.apple.tips" \
  "com.apple.iBooksX" \
  "com.apple.VoiceMemos" \
  "com.apple.podcasts" \
  "com.apple.mail" \
  "com.apple.MobileSMS" \
  "com.apple.Notes" \
  "com.apple.reminders" \
  "com.apple.Photos" \
  "com.apple.AddressBook"

## Spotlight 内のクリップボード履歴 OFF（Maccy を使うため）
defaults write com.apple.Spotlight PasteboardHistoryEnabled -bool false

killall Spotlight 2>/dev/null || true
