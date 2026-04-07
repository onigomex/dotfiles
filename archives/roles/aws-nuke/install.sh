#!/usr/bin/env zsh
set -e

readonly CURRENT_PATH=$(cd $(dirname $0); pwd)
readonly AWS_NUKE_VERSION="2.18.0"

(
cd $HOME/bin
curl -sOL https://github.com/rebuy-de/aws-nuke/releases/download/v${AWS_NUKE_VERSION}/aws-nuke-v${AWS_NUKE_VERSION}.dirty-darwin-arm64.tar.gz
tar zxvf aws-nuke-v${AWS_NUKE_VERSION}.dirty-darwin-arm64.tar.gz
mv -f aws-nuke-v${AWS_NUKE_VERSION}.dirty-darwin-arm64 aws-nuke
rm -f aws-nuke-v${AWS_NUKE_VERSION}.dirty-darwin-arm64.tar.gz
)

(
cd ${CURRENT_PATH}
cp -fr .config ${HOME}
)

