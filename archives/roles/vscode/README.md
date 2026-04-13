# roles/vscode
Visual Studio Code is a code editor redefined and optimized for building and debugging modern web and cloud applications.



## Dependencies
- homebrew



## Settings
1. アカウント > Turn on Settings Sync...
1. すべて選択した上で、Sign in & Turn on > Sign in with GitHub
1. Authorize Visual-Studio-Code で連携する（初回のみ）
1. しばらくすると、Settings Sync is turned on と表示され、リモート/GitHub に保存していた設定がローカルに同期される。


### 設定内容
#### settings
- ~/Library/Application Support/Code/User/settings.json
- Open command palette(Cmd + Shift + P) > Preferences: Open User Settings(JSON)

#### keybinding
- ~/Library/Application Support/Code/User/keybindings.json
- Open command palette(Cmd + Shift + P) > Preferences: Open Keyboard Shortcuts(JSON)

#### extensions
- リポジトリに `.vscode/extensions.json` を配置することで、推奨、非推奨の拡張機能を定義できる。
- 個別インストール（CLI）: `code --install-extension <Extension ID>`
    - Extension ID: 左ペイン > Extensions メニュー > 歯車 > Copy Extension ID
- インストール済み拡張機能リスト:
    ```
    % echo '{\n  "recommendations": [';
    code --list-extensions | while read line; do echo '    '\"$line\",; done;
    echo '  ]\n}';
    ```



## References
- [Visual Studio Code - Code Editing. Redefined](https://code.visualstudio.com/)
- [割と突き詰めてやったvim→vscode移行 - Qiita](https://qiita.com/y-mattun/items/45776b7e1942edb2f727)
- [VSCodeでNERDTreeの操作を再現 - Qiita](https://qiita.com/Kyou13/items/d3dffecbba5b89e8b771)
- [VimmerのVimmerによるVimmerのためのVSCode環境構築(Part1) – Freaky Engineer Notes](https://fe-notes.work/posts/20200708_vsvim01/)
- [VSCodeでいい感じにVimを使うための設定 (Windows) │ wonwon eater](https://wonwon-eater.com/vscode-vim/)
- [VSCode VimからVSCode Neovimに移行した](https://zenn.dev/yubrot/articles/1bf4b8d79d7cae)

