#!/usr/bin/env zsh
set -e

readonly CURRENT_PATH=$(cd $(dirname $0); pwd)

GIT_CONFIG_ROOT_DIR="$HOME/.config/git"
GIT_USERNAME="${GIT_USERNAME:-foo}"
GIT_EMAIL="${GIT_EMAIL:-bar@baz.com}"
GIT_DEFAULT_BRANCH_NAME="${GIT_DEFAULT_BRANCH_NAME:-main}"


brew list git > /dev/null 2>&1 || {
  brew install git
}

# Global Git Profile
git config --global user.name "${GIT_USERNAME}"
git config --global user.email "${GIT_EMAIL}"


mkdir -p ${GIT_CONFIG_ROOT_DIR}

# Global Git ignore
GIT_IGNORE="${GIT_CONFIG_ROOT_DIR}/.gitignore_global"
curl -sL https://raw.githubusercontent.com/github/gitignore/master/Global/macOS.gitignore > "${GIT_IGNORE}"
( cd ${CURRENT_PATH}; cat .gitignore_ownrule >> "${GIT_IGNORE}")
git config --global core.excludesfile "${GIT_IGNORE}"

# Global Git Commit
GIT_COMMIT_FILE=".gitcommit_global"
GIT_COMMIT="${GIT_CONFIG_ROOT_DIR}/${GIT_COMMIT_FILE}"
( cd ${CURRENT_PATH}; cp "${GIT_COMMIT_FILE}" "${GIT_CONFIG_ROOT_DIR}/")
git config --global commit.template "${GIT_COMMIT}"

# Global Git Secret
# ref. https://github.com/awslabs/git-secrets/issues/220#issuecomment-1641285337
# brew list git-secrets > /dev/null 2>&1 || {
#   brew install git-secrets
# }
(
workdir=$(mktemp -d)
git clone https://github.com/awslabs/git-secrets --depth 1 $workdir
cd $workdir
sudo make install
)

GIT_SECRETS="${GIT_CONFIG_ROOT_DIR}/git-secrets"
git secrets --install ${GIT_SECRETS} --force > /dev/null
git config --global init.templatedir ${GIT_SECRETS}

# Global Git default branch name
git config --global init.defaultBranch ${GIT_DEFAULT_BRANCH_NAME}

(
cd ${CURRENT_PATH}
cp -fr .zsh.d ${HOME}
cp -fr bin ${HOME}
chmod +x ${HOME}/bin/*
)
