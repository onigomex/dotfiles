# roles/memo-setup
iCloud Drive/Obsidian に保存している memo を $HOME/memo にリンクする。
ただし、すでに $HOME/memo ディレクトリが存在している場合は何もしない。

Obsidian の設定は、リンクした memo/.obsidian に設定されており、それごとリンクするため、改めて設定することはない。
設定内容は、roles/obsidian/README.md を参照する。

※前提条件: Apple ID でログイン済み、かつ、Obsidian データが同期済みであること。

