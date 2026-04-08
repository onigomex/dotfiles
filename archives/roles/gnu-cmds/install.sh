#!/usr/bin/env zsh
set -e

readonly CURRENT_PATH=$(cd $(dirname $0); pwd)
readonly HOMEBREW_ROOT=$(brew --prefix)
readonly GNU_ROOTPATH=/usr/local/gnu
readonly GNU_BINPATH=${GNU_ROOTPATH}/bin
readonly GNU_MANPATH=${GNU_ROOTPATH}/man


sudo mkdir -p ${GNU_BINPATH}
sudo mkdir -p ${GNU_MANPATH}
sudo chown -R $(whoami):$(groups | cut -d' ' -f1) ${GNU_ROOTPATH}

_install(){
  local brew_name=${1:?[ERROR] brew_name is required.}

  brew list ${brew_name} > /dev/null 2>&1 || {
    brew install ${brew_name}

    ln -fs ${HOMEBREW_ROOT}/opt/${brew_name}/libexec/gnubin/* ${GNU_BINPATH}
    ls ${HOMEBREW_ROOT}/opt/${brew_name}/libexec/gnuman \
    | while read man; do
      mkdir -p ${GNU_MANPATH}/${man};
      ln -fs ${HOMEBREW_ROOT}/opt/${brew_name}/libexec/gnuman/${man}/* ${GNU_MANPATH}/${man};
    done
  }
}

_install coreutils
_install ed
_install findutils
_install gnu-indent
_install gnu-sed
_install gnu-tar
_install gnu-which
_install grep
_install make

(
cd ${CURRENT_PATH}
cp -fr .zsh.d ${HOME}
)

