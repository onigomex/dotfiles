# roles/awscli
aws/aws-cli: Universal Command Line Interface for Amazon Web Services



## Dependencies
- mise



## Setup
See roles/mise



## Usage
### Switch Role
.aws/config に以下を設定したプロファイルを追加すれば良い。

- mfa_serial: スイッチ元の IAM/USER/ARN
  - MFA を設定している場合
  - スイッチ先の OrganizationAccountAccessRole（※role_arn 参照） に対して、AssumeRole できるポリシーをアタッチされた IAM/USER
- role_arn: スイット先の IAM/ROLE/ARN
  - 組織から新規アカウント作成した際のデフォルト IAM ロール名 "OrganizationAccountAccessRole" の場合
  - OrganizationAccountAccessRole ロールは、スイッチ元アカウントから AssumeRole できる信頼関係が設定されていること。

#### 設定例
```
% cat ~/.aws/config
[default]
region = ap-northeast-1
output = json

[profile base-admin]
region = ap-northeast-1
output = json

[profile sandbox]
region = ap-northeast-1
mfa_serial = arn:aws:iam::000000000000:mfa/base-admin
role_arn = arn:aws:iam::111111111111:role/OrganizationAccountAccessRole
source_profile = base-admin
```

#### 使い方
```
% aws s3 ls --profile sandbox

% AWS_PROFILE=sandbox aws s3 ls

% export AWS_PROFILE=sandbox
% aws s3 ls
```



## References
- [aws/aws-cli: Universal Command Line Interface for Amazon Web Services](https://github.com/aws/aws-cli)
- [【小ネタ】AWS CLIでスイッチロールして作業を行うための設定をやってみた | DevelopersIO](https://dev.classmethod.jp/articles/cli-switch-role/)
- [AWS CLIでSwitch Role してさらに Switch Role してみた。（ロールの連鎖:Role chaining） | DevelopersIO](https://dev.classmethod.jp/articles/role-chaining/#toc-16)

