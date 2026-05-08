# roles/git
Git is a free and open source distributed version control system.



## Dependencies
- homebrew
- gnu-cmds
- fzf



## Installation
```
% export GIT_USERNAME="<name>"
% export GIT_EMAIL="<e-mail>"

% make install ROLE=git
```


### Example
```
export GIT_USERNAME=onigomex
export GIT_EMAIL=onigomex+github@gmail.com
make install ROLE=git
```



## git config --global settings


### .gitignore_global
- [GitHub: github/gitignore: A collection of useful .gitignore templates](https://github.com/github/gitignore)
  - https://github.com/github/gitignore/blob/master/Global/macOS.gitignore


### .gitcommit_global
- [Conventional Commits](https://www.conventionalcommits.org)
  - [GitHub: conventional-commits/conventionalcommits.org: The conventional commits specification](https://github.com/conventional-commits/conventionalcommits.org)


### git-secrets
Prevents you from committing secrets and credentials into git repositories

- [GitHub: awslabs/git-secrets: Prevents you from committing secrets and credentials into git repositories](https://github.com/awslabs/git-secrets)


### git default branch name
> To set main as the default branch name do:
> `$ git config --global init.defaultBranch main`

- [Git - First-Time Git Setup > Your default branch name](https://git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup)



## References
- [Git](https://git-scm.com/)

