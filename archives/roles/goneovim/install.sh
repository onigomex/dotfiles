#!/usr/bin/env zsh
set -e

brew list --cask goneovim > /dev/null 2>&1 || {
  brew install goneovim --cask
}
