#!/usr/bin/env zsh
set -e

readonly CURRENT_PATH=$(cd $(dirname $0); pwd)


brew list tfenv > /dev/null 2>&1 || {
  brew install tfenv
}

brew list tgenv > /dev/null 2>&1 || {
  brew install tgenv
}

brew list terraform_landscape > /dev/null 2>&1 || {
  brew install terraform_landscape
}

brew list tflint > /dev/null 2>&1 || {
  brew install tflint
}

brew list tfsec > /dev/null 2>&1 || {
  brew install tfsec
}
