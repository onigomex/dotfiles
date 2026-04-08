#!/usr/bin/env zsh
set -e

mise list python > /dev/null 2>&1 || {
  mise use --global python
}

