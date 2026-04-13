#!/usr/bin/env zsh
set -e

readonly CURRENT_PATH=$(cd $(dirname $0); pwd)


brew list finch > /dev/null 2>&1 || {
  brew install --cask finch
}

