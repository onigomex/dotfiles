# roles/asdf
asdf-vm/asdf: Extendable version manager with support for Ruby, Node.js, Elixir, Erlang & more



## Dependencies
- homebrew



## Usage
1. 該当のツールのプラグインを追加
1. それで管理しているツールをインストール
1. バージョンを必要に応じて切り替える
- e.g. awscli


### プラグイン追加
```
% asdf plugin list-all | grep aws
aws-copilot                   https://github.com/NeoHsu/asdf-copilot
aws-iam-authenticator         https://github.com/stefansedich/asdf-aws-iam-authenticator.git
aws-nuke                      https://github.com/bersalazar/asdf-aws-nuke.git
aws-sam-cli                   https://github.com/amrox/asdf-pyapp.git
aws-vault                     https://github.com/karancode/asdf-aws-vault.git
awscli                       *https://github.com/MetricMike/asdf-awscli.git
awsebcli                      https://github.com/amrox/asdf-pyapp.git
saml2aws                      https://github.com/elementalvoid/asdf-saml2aws.git

% asdf plugin add awscli
```


### インストール
```
% asdf install awscli latest

# java
% asdf install java latest:corretto-8
```

#### バージョン指定
```
% asdf list-all awscli | grep ^\[0-9\]\.\* | sort -nr | head -n 5
2.9.9
2.9.8
2.9.7
2.9.6
2.9.5

% asdf install awscli 2.6.0
awscli 2.6.0 installation was successful!

# latest
% asdf install awscli latest
```


### 使用バージョン設定
```
% asdf global awscli 2.6.0

# latest
% asdf global awscli latest
```

#### そのディレクトリだけ有効化
```
% asdf local awscli 2.7.4
% aws --version
aws-cli/2.7.4 Python/3.9.11 Darwin/22.6.0 exe/x86_64 prompt/off

% cat .tool-versions
awscli 2.7.4
% rm .tool-versions

% aws --version
aws-cli/2.15.6 Python/3.11.6 Darwin/22.6.0 exe/x86_64 prompt/off
```

#### そのシェルだけ有効化
```
% asdf shell awscli 2.7.4
% aws --version
aws-cli/2.7.4 Python/3.9.11 Darwin/22.6.0 exe/x86_64 prompt/off

# 無効化（元に戻す）
% asdf shell awscli --unset
% aws --version
aws-cli/2.15.6 Python/3.11.6 Darwin/22.6.0 exe/x86_64 prompt/off
```


### 現在の管理リスト
```
% asdf list
java
  corretto-11.0.21.9.1
 *corretto-21.0.1.12.1
nodejs
  17.5.0
 *21.5.0
ruby
  3.0.2
 *3.1.2

# plugin 指定
% asdf list ruby
  3.0.2
 *3.1.2
```


### Uninstall tool version
```
% asdf uninstall awscli 2.6.0

# all
% asdf uninstall awscli
```

### Uninstall plugin
```
% asdf plugin remove awscli
```


### プラグイン Update
```
% asdf plugin update awscli
```

### カレントバージョンを表示
```
% asdf current awscli
awscli          2.6.1           /Users/xxxxx/.tool-versions
```

### latest 表示
```
% asdf latest awscli
2.15.6
```


### asdf info（プラグインがどのリポジトリか確認）
```
% asdf info | grep awscli
awscli                       https://github.com/MetricMike/asdf-awscli.git main ec4ccdc
```



## References
- [asdf-vm/asdf: Extendable version manager with support for Ruby, Node.js, Elixir, Erlang & more](https://github.com/asdf-vm/asdf)
- [バージョン管理ツール「asdf」を使ってみる | 働くひとと組織の健康を創る iCARE](https://dev.icare.jpn.com/dev_cat/how_to_use_asdf/)

