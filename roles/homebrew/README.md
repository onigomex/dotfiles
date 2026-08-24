# roles/homebrew
macOS のパッケージ管理。ほぼ全ロールの土台



## Dependencies
- nothing



## Usage
```
brew install <name>          # コマンド
brew install <name> --cask   # GUI アプリ
brew list                    # 入っているもの
brew upgrade                 # まとめて更新（このツールは面倒を見ない）
brew info <name>             # formula の確認
```
このリポジトリのほぼ全ロールが `brew install` で入る。



## References
- [The Missing Package Manager for macOS (or Linux) — Homebrew](https://brew.sh/index_ja)

