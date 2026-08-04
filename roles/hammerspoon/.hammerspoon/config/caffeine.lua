-- Caffeine（スリープ防止）: 起動時にオン・hyper+F6 でトグル

-- Load Spoons: https://github.com/Hammerspoon/Spoons
hs.loadSpoon("Caffeine")
spoon.Caffeine:bindHotkeys({toggle={hyper, "f6"}})
spoon.Caffeine:start()
spoon.Caffeine:clicked()
