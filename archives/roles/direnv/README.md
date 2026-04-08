# roles/direnv
direnv/direnv: unclutter your .profile



## Dependencies
- homebrew



## Usage
### .env ファイルのように使いたい
`echo dotenv > .envrc` としておくことで、`.env` ファイルが使える。
メリットは、`export 環境変数=値` ではなく、`環境変数=値` と定義できること。
この形式であれば、docker `--env-file` など対応している場合が多く使いやすい。



## References
- [direnv/direnv: unclutter your .profile](https://github.com/direnv/direnv)

