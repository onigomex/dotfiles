#!/usr/bin/env zsh
set -e

# Terminal
# 単体実行: zsh roles/macos/settings.d/terminal.sh
# ※出力されたコマンドを手動で流して設定する（プロファイルを open するとプロセスが移行してしまうため）。
# - [x] Startup / Default: Nord
# - [x] Shell > When the shell exits: Close the window
# - [x] Advanced > Bell: OFF

## Install ColorScheme for Terminal.app
_profile='Nord'
_profile_file="${_profile}.terminal"
_profile_dir="$HOME/.config/colorscheme"
_profile_url="https://raw.githubusercontent.com/arcticicestudio/nord-terminal-app/develop/src/xml/${_profile_file}"
mkdir -p "${_profile_dir}"
curl -sL -o "${_profile_dir}/${_profile_file}" "${_profile_url}"
# open ${_profile_dir}/${_profile_file}

## Profile > Default, Startup
# defaults write com.apple.Terminal "Default Window Settings" -string "${_profile}"
# defaults write com.apple.Terminal "Startup Window Settings" -string "${_profile}"
## Shell > When the shell exits: Close the window
# /usr/libexec/PlistBuddy -c "Add 'Window Settings':${_profile}:shellExitAction integer 0" $HOME/Library/Preferences/com.apple.Terminal.plist
## Advanced > Bell: OFF
# /usr/libexec/PlistBuddy -c "Add 'Window Settings':${_profile}:Bell bool false" $HOME/Library/Preferences/com.apple.Terminal.plist
# /usr/libexec/PlistBuddy -c "Add 'Window Settings':${_profile}:VisualBell bool false" $HOME/Library/Preferences/com.apple.Terminal.plist
# /usr/libexec/PlistBuddy -c "Add 'Window Settings':${_profile}:BellBadge bool false" $HOME/Library/Preferences/com.apple.Terminal.plist
# /usr/libexec/PlistBuddy -c "Add 'Window Settings':${_profile}:BellBounce bool false" $HOME/Library/Preferences/com.apple.Terminal.plist

cat << EOF
# Execute the following commands manually.
open ${_profile_dir}/${_profile_file}
defaults write com.apple.Terminal "Default Window Settings" -string "${_profile}"
defaults write com.apple.Terminal "Startup Window Settings" -string "${_profile}"
/usr/libexec/PlistBuddy -c "Add 'Window Settings':${_profile}:shellExitAction integer 0" $HOME/Library/Preferences/com.apple.Terminal.plist
/usr/libexec/PlistBuddy -c "Add 'Window Settings':${_profile}:Bell bool false" $HOME/Library/Preferences/com.apple.Terminal.plist
/usr/libexec/PlistBuddy -c "Add 'Window Settings':${_profile}:VisualBell bool false" $HOME/Library/Preferences/com.apple.Terminal.plist
/usr/libexec/PlistBuddy -c "Add 'Window Settings':${_profile}:BellBadge bool false" $HOME/Library/Preferences/com.apple.Terminal.plist
/usr/libexec/PlistBuddy -c "Add 'Window Settings':${_profile}:BellBounce bool false" $HOME/Library/Preferences/com.apple.Terminal.plist
EOF
