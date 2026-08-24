# roles/ssh
~/.ssh の鍵をまとめて ssh-add するコマンドを配る



## Dependencies
- gnu-cmds



## Usage
```
ssh-add-keys          # ~/.ssh/*.pem を chmod 600 して ssh-add し、登録済みを一覧表示
```
鍵そのものはこのリポジトリでは管理しない（`~/.ssh` に自分で置く）。



## SSH configuration
```
% tree .ssh
.ssh
├── config
├── conf.d
│   ├── aws
│   ├── github
│   └── ...
├── aws-20210101.pem
├── github-20210101.pem
├── ...
└── known_hosts

% cat ~/.ssh/config
Include conf.d/*
```



## GitHub
If you are using multiple github account, set the <YOUR_GITHUB_PRIVAE_KEY> to IdentityFile

```
Host github.com
  HostName github.com
  User git
  Port 22
  IdentityFile ~/.ssh/<YOUR_GITHUB_PRIVAE_KEY>
```



## ssh localhost
System Preferences > Sharing

- [x] Remote Login

