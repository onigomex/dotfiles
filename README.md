# dotfiles
onigri10co's dotfiles



## Installation
```
% curl -fsSL https://raw.githubusercontent.com/onigiri10co/dotfiles/HEAD/install.sh | zsh

# another way
% git clone https://github.com/onigiri10co/dotfiles.git
% cd dotfiles
% make install-all

# by ROLE
% make install ROLE=vim
```


### NOTE: sudo password
```
# If you make the following settings in advance, you will not be asked for sudo password.
% sudo sh -c "echo $(whoami) ALL=\(ALL\) NOPASSWD:ALL > /private/etc/sudoers.d/$(whoami)"

# Delete it if it is not necessary after the installation is completed.
% sudo rm -f /private/etc/sudoers.d/$(whoami)
```



## Configuration
You can override the configuration values for particular role by setting them before installation.

### roles/git
```
% export GIT_USERNAME=foo
% export GIT_EMAIL=bar@baz.com
```



## Development
### Specify the branch
```
% export DOTF_BRANCH="development"
% curl -fsSL https://raw.githubusercontent.com/onigiri10co/dotfiles/${DOTF_BRANCH}/install.sh | zsh
```


### Create ROLE
```
% make create ROLE=vim
```

1. Define the dependent role names on the `roles/<ROLE>/dependencies` file. If does not exist, empty it or delete it.
1. Implement `roles/<ROLE>/install.sh` file.
1. If you want to define environment variables, define it in the `roles/<ROLE>/.zsh.d/<ROLE>.zshrc.env` file.
1. If you want to define alias, define it in the `roles/<ROLE>/.zsh.d/<ROLE>.zshrc.alias` file.
1. If you want to define other processes, define it in the `roles/<ROLE>/.zsh.d/<ROLE>.zshrc` file.

