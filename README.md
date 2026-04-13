# dotfiles
My dotfiles


## Setup
### sudo
```
echo "$(whoami) ALL=(ALL) NOPASSWD: ALL" | sudo tee /private/etc/sudoers.d/$(whoami)
sudo chmod 0440 /private/etc/sudoers.d/$(whoami)
sudo visudo -c

# Delete it if it is not necessary after the installation is completed.
sudo rm -f /private/etc/sudoers.d/$(whoami)
```

### Xcode
```
xcode-select --install
```


## Installation
```
curl -fsSL https://raw.githubusercontent.com/onigomex/dotfiles/HEAD/install | zsh
```

### Specify a branch
```
export DOTF_BRANCH=example
curl -fsSL https://raw.githubusercontent.com/onigomex/dotfiles/$DOTF_BRANCH/install | zsh
```

### Specify a role file
```
export DOTF_ROLES_FILE=roles.work.lst
curl -fsSL https://raw.githubusercontent.com/onigomex/dotfiles/HEAD/install | zsh
```

### Create a role file and specify it
```
export DOTF_ROLES_FILE=`pwd`/roles.txt
cat << EOF > $DOTF_ROLES_FILE
fzf
git
tig
EOF
curl -fsSL https://raw.githubusercontent.com/onigomex/dotfiles/HEAD/install | zsh
```

#### $DOTF_ROLES_FILE
'#' is a comment, blank lines are ignored.

```
fzf
git

#ghq
tig
```

### Clone the repository locally and install per role
```
git clone https://github.com/onigomex/dotfiles.git
cd dotfiles
make install
make install ROLE=vim
```


## Development
### Specify the branch
```
export DOTF_BRANCH="develop"
curl -fsSL https://raw.githubusercontent.com/onigomex/dotfiles/$DOTF_BRANCH/install | zsh
```


### Create ROLE
```
make create ROLE=vim
```

1. Define the dependent role names on the `roles/<ROLE>/dependencies` file. If does not exist, empty it or delete it.
1. Implement `roles/<ROLE>/install.sh` file.
1. If you want to define environment variables, define it in the `roles/<ROLE>/.zsh.d/<ROLE>.zshrc.env` file.
1. If you want to define alias, define it in the `roles/<ROLE>/.zsh.d/<ROLE>.zshrc.alias` file.
1. If you want to define other processes, define it in the `roles/<ROLE>/.zsh.d/<ROLE>.zshrc` file.


### Update images
```
% git fetch; git branch -a
% git checkout images
# after update contents
% git push origin images
```

