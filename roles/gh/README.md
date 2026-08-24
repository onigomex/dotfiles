# roles/gh
GitHub の CLI。PR とリポジトリ操作をターミナルから



## Dependencies
- homebrew



## Setup
```
% gh auth login
? What account do you want to log into? GitHub.com
? What is your preferred protocol for Git operations? HTTPS
? Authenticate Git with your GitHub credentials? Yes
? How would you like to authenticate GitHub CLI? Login with a web browser
```


### After Setup
[Account > Settings > Applications > Authorized OAuth Apps](https://github.com/settings/applications)

- GiHub CLI



## Usage
```
gh pr create          # PR を作る
gh pr view --web      # ブラウザで開く
gh pr list
gh api repos/:owner/:repo/...   # API を直に叩く
```
**初回のサインイン（`gh auth login`）は手動。**



## References
- [cli/cli: GitHub’s official command line tool](https://github.com/cli/cli)

