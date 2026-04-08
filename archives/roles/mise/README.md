# roles/mise
dev tools, env vars, task runner

> What is it?
> Like asdf (or nvm or pyenv but for any language) it manages dev tools like node, python, cmake, terraform, and hundreds more.
> Like direnv it manages environment variables for different project directories.
> Like make it manages tasks used to build and test projects.



## Dependencies
- nothing



## Usage
### Like asdf
- `~/.config/mise/config.toml` がデフォルトだが、`~/.tool-versions` に記載しても自動でロードしてくれる。

```
% cat ~/.tool-versions
awscli 2.15.10
java corretto-21.0.1.12.1

% mise list
Tool    Version               Config Source              Requested
awscli  2.15.10               ~/.tool-versions           2.15.10
java    corretto-21.0.1.12.1  ~/.tool-versions           corretto-21.0.1.12.1

$ mise use --global node@20
$ node -v
v20.17.0

$ mise use --global deno
% deno --version
deno 1.46.3 (stable, release, aarch64-apple-darwin)
v8 12.9.202.5-rusty
typescript 5.5.2

% mise ls
Tool    Version               Config Source              Requested
awscli  2.15.10               ~/.tool-versions           2.15.10
deno    1.46.3                ~/.config/mise/config.toml latest
java    corretto-21.0.1.12.1  ~/.tool-versions           corretto-21.0.1.12.1
node    20.17.0               ~/.config/mise/config.toml 20

% cat ~/.config/mise/config.toml
[tools]
node = "20"
deno = "latest"
```

#### 特定のディレクトリ配下だけで使う
- `.mise.toml` に tool 定義を記載するだけで使用できる。

```
% mise use go@1.8
% go version
go version go1.18 darwin/arm64
% cat .mise.toml
[tools]
go = "1.18"

# .mise.toml を直接編集した場合、mise install でインストールできる
% cat << EOF > .mise.toml
[tools]
go = "1.22.7"
EOF
mise missing: go@1.22.7
% mise install
% go version
go version go1.22.7 darwin/arm64
```


### Like direnv
- 特定のディレクトリ配下でのみ有効な env を設定できる。
- .env ファイルも併用できるため、例えば .env は .gitignore にしておき、秘匿情報を管理するというような使い方もできる。

```
% cat << EOF > .env
SECRET_VALUE = "secret-value"
EOF

% cat << EOF >> .mise.toml
[env]
ENV_NAME = "develop"
mise.file = ".env"
EOF

% mise trust

% echo "$ENV_NAME $SECRET_VALUE"
develop secret-value
```


#### Auto python venv activate/deactivate
- .mise.toml に、以下のように設定しておけば、`source .venv/bin/activate` を自動で行える。

```
[tools]
python = "3.10"

[env]
_.python.venv = "venv"
```


### Like make
- make（タスク機能）は、実験的機能のため `MISE_EXPERIMENTAL = 1` などで明示的に有効化する必要がある。

```
% cat << EOF >> .mise.toml
[env]
MISE_EXPERIMENTAL = 1
[tasks.example]
description = "example"
run = "go version"
EOF

% mise run example
[example] $ go version
go version go1.22.7 darwin/arm64
```



## References
- [jdx/mise: dev tools, env vars, task runner](https://github.com/jdx/mise?tab=readme-ov-file)
- [mise ではじめる開発環境構築](https://zenn.dev/takamura/articles/dev-started-with-mise)
- [asdf互換のmiseを試してみた](https://zenn.dev/gw31415/articles/mise-asdf-trial#python-venv-%E3%81%A8%E3%81%AE%E9%80%A3%E6%90%BA)
- [Python | mise-en-place#automatic-virtualenv-activation](https://mise.jdx.dev/lang/python.html#automatic-virtualenv-activation)

