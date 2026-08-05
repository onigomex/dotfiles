-- クリップボード履歴（ClipboardTool・SpoonInstall 経由）。
-- Maccy からの乗り換え候補として試用中（当面 Maccy と併用）。テキスト専用。
-- 画像は対象外（必要なら macOS Spotlight のクリップボード履歴を別途 ON）。
-- ※ ホットキー/設定は好みで調整可。

hs.loadSpoon("SpoonInstall")
spoon.SpoonInstall:andUse("ClipboardTool", {
  config = {
    hist_size = 200,          -- 履歴の保持数
    paste_on_select = true,   -- 選択した項目を現アプリへ自動ペースト
    show_in_menubar = true,   -- メニューバーアイコンを表示
  },
  hotkeys = {
    -- ⌘⇧V で履歴チューザを開く（Maccy の既定 ⌘⇧C と衝突しないよう別キーにしている）
    show_clipboard = {{"cmd", "shift"}, "v"},
  },
  start = true,
})
