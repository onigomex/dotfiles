-- Caffeine（スリープ防止）: 起動時にオン・hyper+F6 でトグル
-- SpoonInstall 経由で宣言的に導入する（未インストールなら公式リポジトリから自動取得）。
-- 順序は従来どおり bindHotkeys → start() → clicked()。andUse の start=true は使わず
-- fn 内で start→clicked を呼ぶことで、clicked を start の後に確実に実行する。

hs.loadSpoon("SpoonInstall")
local Install = spoon.SpoonInstall

Install:andUse("Caffeine", {
  hotkeys = { toggle = {hyper, "f6"} },
  fn = function(s)
    s:start()
    s:clicked()
  end,
})
