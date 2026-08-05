-- 選択テキストの翻訳ポップアップ（PopupTranslateSelection・SpoonInstall 経由）。
-- 言語コードは Google 翻訳準拠の 2 文字（en / ja など）。
-- ※ ホットキーは好みで調整可。

hs.loadSpoon("SpoonInstall")
spoon.SpoonInstall:andUse("PopupTranslateSelection", {
  hotkeys = {
    translate       = {{"cmd", "ctrl"}, "t"},   -- ⌘⌃T: 言語自動検出で翻訳
    translate_to_ja = {{"cmd", "ctrl"}, "j"},   -- ⌘⌃J: 日本語へ
    translate_to_en = {{"cmd", "ctrl"}, "e"},   -- ⌘⌃E: 英語へ
  },
})
