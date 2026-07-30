#!/usr/bin/env zsh
set -e


brew list node > /dev/null 2>&1 || {
  brew install node
}
