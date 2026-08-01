#!/usr/bin/env zsh
set -e


brew list --cask obsidian > /dev/null 2>&1 || {
  brew install obsidian --cask
}
