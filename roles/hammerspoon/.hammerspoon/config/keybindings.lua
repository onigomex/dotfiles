-- 自分が Hammerspoon に登録したショートカット一覧を表示（HSKeybindings・SpoonInstall 経由）。
-- HSKeybindings は bindHotkeys を持たないため、fn 内で show() を手動 bind する。
-- ※ この spoon はライブ未検証。反映後に ⌘⇧K で表示を確認し、必要なら調整する。

hs.loadSpoon("SpoonInstall")
spoon.SpoonInstall:andUse("HSKeybindings", {
  fn = function(s)
    hs.hotkey.bind({"cmd", "shift"}, "k", function() s:show() end)   -- ⌘⇧K で一覧表示
  end,
})
