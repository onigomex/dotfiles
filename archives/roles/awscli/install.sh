#!/usr/bin/env zsh
set -e

mise list awscli > /dev/null 2>&1 || {
  mise use --global awscli
}

