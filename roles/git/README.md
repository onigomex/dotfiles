# roles/git
git 本体と、グローバル設定（ignore / commit テンプレ / secrets）



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



## Usage
自作コマンドが `~/bin` に入る（一覧は `help`）。

```
gci                   # commit id を fzf で選んで出力
gbr                   # ブランチ一覧
gpn                   # PR 番号
gci-rebase            # rebase 用に「選んだ 1 つ前」の commit id
```
グローバル設定は `~/.config/git/` に置かれる（`.gitignore_global` / `.gitcommit_global` / git-secrets のフック）。`git commit` するとテンプレートが開く。



## References
- [Git](https://git-scm.com/)

