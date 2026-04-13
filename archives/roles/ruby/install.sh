#!/usr/bin/env zsh
set -e

mise list ruby > /dev/null 2>&1 || {
  mise use --global ruby
}

