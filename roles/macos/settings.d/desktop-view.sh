#!/usr/bin/env zsh
set -e

# Desktop > Show View Options
# 単体実行: zsh roles/macos/settings.d/desktop-view.sh
# - [x] Sort By: Name
# - [x] Icon size: 20 x 20
# - [x] Grid spacing: max(=100)
# - [x] Text size: 10
# - [x] Label position: Right

# See: https://github.com/jmalloc/dotfiles/issues/12
plist_set_or_add () {
  /usr/libexec/PlistBuddy -c "Set $1" "${@:2}" ||
  /usr/libexec/PlistBuddy -c "Add $1" "${@:2}" ||
  echo "Unable to set or add plist with args:" "$@"
}

## Sort By: Name
plist_set_or_add ":DesktopViewSettings:IconViewSettings:arrangeBy name" "$HOME/Library/Preferences/com.apple.finder.plist"
plist_set_or_add ":FK_StandardViewSettings:IconViewSettings:arrangeBy name" "$HOME/Library/Preferences/com.apple.finder.plist"
plist_set_or_add ":StandardViewSettings:IconViewSettings:arrangeBy name" "$HOME/Library/Preferences/com.apple.finder.plist"
## Icon size: 20 x 20
plist_set_or_add ":DesktopViewSettings:IconViewSettings:iconSize 20" "$HOME/Library/Preferences/com.apple.finder.plist"
plist_set_or_add ":FK_StandardViewSettings:IconViewSettings:iconSize 20" "$HOME/Library/Preferences/com.apple.finder.plist"
plist_set_or_add ":StandardViewSettings:IconViewSettings:iconSize 20" "$HOME/Library/Preferences/com.apple.finder.plist"
## Grid spacing: max(=100)
plist_set_or_add ":DesktopViewSettings:IconViewSettings:gridSpacing 100" "$HOME/Library/Preferences/com.apple.finder.plist"
plist_set_or_add ":FK_StandardViewSettings:IconViewSettings:gridSpacing 100" "$HOME/Library/Preferences/com.apple.finder.plist"
plist_set_or_add ":StandardViewSettings:IconViewSettings:gridSpacing 100" "$HOME/Library/Preferences/com.apple.finder.plist"
## Text size: 10
plist_set_or_add ":DesktopViewSettings:IconViewSettings:textSize 10" "$HOME/Library/Preferences/com.apple.finder.plist"
plist_set_or_add ":FK_StandardViewSettings:IconViewSettings:textSize 10" "$HOME/Library/Preferences/com.apple.finder.plist"
plist_set_or_add ":StandardViewSettings:IconViewSettings:textSize 10" "$HOME/Library/Preferences/com.apple.finder.plist"
## Label position: Right
plist_set_or_add ":DesktopViewSettings:IconViewSettings:labelOnBottom false" "$HOME/Library/Preferences/com.apple.finder.plist"
plist_set_or_add ":FK_StandardViewSettings:IconViewSettings:labelOnBottom false" "$HOME/Library/Preferences/com.apple.finder.plist"
plist_set_or_add ":StandardViewSettings:IconViewSettings:labelOnBottom false" "$HOME/Library/Preferences/com.apple.finder.plist"
