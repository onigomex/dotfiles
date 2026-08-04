-- Config loaded auto, when save init.lua file
function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.notify.new({title="Hammerspoon", informativeText="Config loaded"}):send()


-- Preferences > Behavior（GUI のチェック状態をコードで固定・冪等）
hs.autoLaunch(true)                     -- Launch Hammerspoon at login: ON
hs.automaticallyCheckForUpdates(true)   -- Check for updates: ON
hs.dockIcon(false)                      -- Show dock icon: OFF
hs.menuIcon(true)                       -- Show menu icon: ON
hs.consoleOnTop(false)                  -- Keep Console window on top: OFF
hs.uploadCrashData(false)               -- Send crash data: OFF


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
hs.hotkey.bind(cmd_shift, 41, function() toggle_application("WezTerm") end)
hs.hotkey.bind(cmd_shift, 47, function() toggle_application("Google Chrome") end)


-- Switch between En, Ja
local simpleCmd = false
local leftSet = false
local rightSet = false

local leftCmd = 0x37
local rightCmd = 0x36
local eisuu = 0x66
local kana = 0x68

local function keyStroke(modifiers, character)
    hs.eventtap.keyStroke(modifiers, character, 5000)
end

local function eikanaEvent(event)
    local c = event:getKeyCode()
    local f = event:getFlags()
    if event:getType() == hs.eventtap.event.types.keyDown then
        if f['cmd'] and c then
            simpleCmd = true
        end
    elseif event:getType() == hs.eventtap.event.types.flagsChanged then
        if f['cmd'] then
            if c  == leftCmd then
                leftSet = true
                rightSet = false
            elseif c == rightCmd then
                rightSet = true
                leftSet = false
            end
        else
            if simpleCmd == false then
                if leftSet then
                    keyStroke({}, eisuu)
                elseif rightSet then
                    keyStroke({}, kana)
                end
            end
                simpleCmd = false
                leftSet = false
                rightSet = false
        end
    end
end

eikana = hs.eventtap.new({hs.eventtap.event.types.keyDown, hs.eventtap.event.types.flagsChanged}, eikanaEvent)
eikana:start()


-- Load Spoons: https://github.com/Hammerspoon/Spoons
hs.loadSpoon("Caffeine")
spoon.Caffeine:bindHotkeys({toggle={hyper, "f6"}})
spoon.Caffeine:start()
spoon.Caffeine:clicked()

