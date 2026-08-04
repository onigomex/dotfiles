-- アプリ トグル（同じキーで 表示/隠す を切替）

-- Toggle Application
local previous_app = nil
local cmd_shift = {"cmd", "shift"}
function toggle_application(_app)
    local front_app = hs.application.frontmostApplication()
    if front_app:name() ~= _app then
        previous_app = front_app
    end
    local app = hs.appfinder.appFromName(_app)
    if not app then
        hs.application.launchOrFocus(_app)
        return
    end
    local mainwin = app:mainWindow()
    if mainwin then
        if mainwin == hs.window.focusedWindow() then
            mainwin:application():hide()
            if previous_app:mainWindow() then
                previous_app:mainWindow():focus()
            end
        else
            mainwin:application():activate(true)
            mainwin:application():unhide()
            mainwin:focus()
        end
    end
end
-- keymap: Console > hs.inspect(hs.keycodes.map)
-- smei_colon:41, dot:47, comma:43, lightcmd:54
hs.hotkey.bind(cmd_shift, 41, function() toggle_application("Ghostty") end)       -- ⌘⇧; (セミコロン)
hs.hotkey.bind(cmd_shift, 47, function() toggle_application("Google Chrome") end) -- ⌘⇧. (ピリオド)
