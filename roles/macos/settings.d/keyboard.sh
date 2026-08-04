#!/usr/bin/env zsh
set -e

# Keyboard
# 単体実行: zsh roles/macos/settings.d/keyboard.sh
# - [x] Keyboard Shortcuts > Modifier Keys > Caps Lock Key: ^Control
# - [x] Function Keys > Use F1,F2, etc. keys as standard function keys: true

## Keyboard Shortcuts > Modifier Keys > Caps Lock Key: Control
## keyboard_id は実機の内蔵キーボードから毎回算出（マシンに追従）。
## -array（置換）で書くこと。-array-add だと実行の度に dict が重複追加され非冪等になる。
keyboard_id="$(ioreg -c AppleEmbeddedKeyboard -r | grep -Eiw "VendorID|ProductID" | awk '{ print $4 }' | paste -s -d'-\n' -)-0"
defaults -currentHost write -g com.apple.keyboard.modifiermapping.${keyboard_id} -array "
<dict>
  <key>HIDKeyboardModifierMappingDst</key>\
  <integer>30064771300</integer>\
  <key>HIDKeyboardModifierMappingSrc</key>\
  <integer>30064771129</integer>\
</dict>
"
## Function Keys > Use F1,F2, etc. kyes as standard function keys: true
defaults write -g com.apple.keyboard.fnState -bool true
