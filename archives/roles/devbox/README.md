# roles/devbox
Instant, easy, and predictable development environments

- 独立した開発環境（複数可）を構築できる CLI ツール（Jetpack.io製）。
- devbox shell で開発環境にアタッチできる。exit するれば元の環境に戻る。
- Docker に依存しておらず速い。Nix パッケージマネージャーベース（初回に自動インストール）。
- devbox.json で環境を定義でき、再現性がある。
- devbox genreate {dockerfile,devcontainer} コマンドでそれらの設定を出力することもできるため、途中で環境の切替も可能。



## Dependencies
- nothing



## Usage
### Example Laravel environment
```
% devbox init
% devbox search php
% devbox add php@8.3.9
% devbox shell

(devbox) % php -v
PHP 8.3.9 (cli) (built: Jul  2 2024 14:10:14) (NTS)
(devbox) % composer -V
Composer version 2.7.7 2024-06-10 22:11:12

(devbox) % composer create-project laravel/laravel app-name
(devbox) % cd app-name
(devbox) % php artisan -V
Laravel Framework 11.17.0

(devbox) % php artisan serve
(devbox) % open http://127.0.0.1:8000/
(devbox) % exit
```



## References
- [jetify-com/devbox: Instant, easy, and predictable development environments](https://github.com/jetify-com/devbox)
- [Devbox: Portable, Isolated Dev Environments](https://www.jetify.com/devbox/)

