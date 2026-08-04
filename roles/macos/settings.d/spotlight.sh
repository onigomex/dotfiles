#!/usr/bin/env zsh
set -e

# Siri & Spotlight
# 単体実行: zsh roles/macos/settings.d/spotlight.sh
# - [ ] Search results（Applications / Folders のみ ON）

## Search results
### FIXME: まともに動かないのでいつか修正する。 See: https://github.com/search?q=defaults+write+com.apple.spotlight+orderedItems&type=code
# defaults write com.apple.spotlight orderedItems -array \
#   '{ "enabled" = 1; "name" = "APPLICATIONS"; }' \
#   '{ "enabled" = 1; "name" = "MENU_EXPRESSION"; }' \
#   '{ "enabled" = 0; "name" = "CONTACT"; }' \
#   '{ "enabled" = 0; "name" = "MENU_CONVERSION"; }' \
#   '{ "enabled" = 0; "name" = "MENU_DEFINITION"; }' \
#   '{ "enabled" = 0; "name" = "DOCUMENTS"; }' \
#   '{ "enabled" = 0; "name" = "EVENT_TODO"; }' \
#   '{ "enabled" = 1; "name" = "DIRECTORIES"; }' \
#   '{ "enabled" = 0; "name" = "FONTS"; }' \
#   '{ "enabled" = 0; "name" = "IMAGES"; }' \
#   '{ "enabled" = 0; "name" = "MESSAGES"; }' \
#   '{ "enabled" = 0; "name" = "MOVIES"; }' \
#   '{ "enabled" = 0; "name" = "MUSIC"; }' \
#   '{ "enabled" = 0; "name" = "MENU_OTHER"; }' \
#   '{ "enabled" = 0; "name" = "PDF"; }' \
#   '{ "enabled" = 0; "name" = "PRESENTATIONS"; }' \
#   '{ "enabled" = 0; "name" = "MENU_SPOTLIGHT_SUGGESTIONS"; }' \
#   '{ "enabled" = 0; "name" = "SPREADSHEETS"; }' \
#   '{ "enabled" = 1; "name" = "SYSTEM_PREFS"; }' \
#   '{ "enabled" = 0; "name" = "TIPS"; }' \
#   '{ "enabled" = 0; "name" = "BOOKMARKS"; }'
