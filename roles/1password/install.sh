#!/usr/bin/env zsh
set -e

readonly CURRENT_PATH=$(cd $(dirname $0); pwd)


brew list --cask 1password > /dev/null 2>&1 || {
  brew install 1password --cask
}

