-- 設定は責務ごとに config/*.lua へ分割している。ここは読み込むだけの薄いローダー。
-- 追加/削除は config/ にファイルを置き、この require 一覧に足す/消すだけ。
-- Hammerspoon は既定で ~/.hammerspoon を package.path に含むため require("config.x") で
-- config/x.lua を読める。pathwatcher は ~/.hammerspoon 配下を再帰監視するので、
-- config/*.lua を編集しても自動リロードされる。
require("config.reload")       -- 設定オートリロード
require("config.behavior")     -- Preferences > Behavior
require("config.app_toggle")   -- アプリ トグル（ホットキー）
require("config.ime")          -- En/Ja 切替
require("config.caffeine")     -- Caffeine（スリープ防止）
require("config.clipboard")    -- クリップボード履歴（ClipboardTool・試用）
require("config.translate")    -- 選択テキストの翻訳（PopupTranslateSelection）
require("config.keybindings")  -- 自分のショートカット一覧（HSKeybindings・未検証のため最後）
