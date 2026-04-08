#!/usr/bin/env zsh
set -e

mise list java > /dev/null 2>&1 || {
  mise use --global java@corretto
}

