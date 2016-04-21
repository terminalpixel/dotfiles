--------------------------------------------------------------------------------
-- Unsupported Spaces extension. Uses private APIs but works okay.
-- (http://github.com/asmagill/hammerspoon_asm.undocumented)
-- spaces = require("hs._asm.undocumented.spaces")


local super = {"alt"}
local super_shift = {"alt", "shift"}
local terminal = "iTerm"
local browser = "Google Chrome"
local editor = "Sublime Text"
local mail = "Airmail 2"
local launcher = "Alfred 2"
local todo = "Todoist"
local music = "Spotify"
local messenger = "Franz"


hs.hotkey.bind(super_shift, "R", function()
  hs.reload()
  hs.alert.show('Hammerspoon reloaded')
end)

hs.hotkey.bind(super_shift, "C", function()
  local win = hs.window.focusedWindow()
  win:close()
end)

hs.hotkey.bind(super, "return", function()
  hs.application.launchOrFocus(terminal)
end)

hs.hotkey.bind(super, "P", function()
  hs.application.launchOrFocus(launcher)
end)

hs.hotkey.bind(super, "E", function()
  hs.application.launchOrFocus(editor)
end)

hs.hotkey.bind(super, "B", function()
  hs.application.launchOrFocus(browser)
end)

hs.hotkey.bind(super, "M", function()
  hs.application.launchOrFocus(mail)
end)

hs.hotkey.bind(super, "T", function()
  hs.application.launchOrFocus(todo)
end)

hs.hotkey.bind(super, "S", function()
  hs.application.launchOrFocus(music)
end)

hs.hotkey.bind(super, "C", function()
  hs.application.launchOrFocus(messenger)
end)

-- hs.hotkey.bind(super, "N", function()
--     local win = hs.window.focusedWindow()
--     if win:application():title() == terminal then
--        win:focusWindowWest()
--     else
--         hs.applescript.applescript('tell application terminal to (activate)')
--         hs.applescript.applescript('tell application terminal to (launch session "ncmpcpp")')
--     end
-- end)
hs.hotkey.bind(super, "H", function()
    hs.eventtap.keyStroke({"ctrl"}, "Left")
end)

hs.hotkey.bind(super, "L", function()
    hs.eventtap.keyStroke({"ctrl"}, "Right")
end)

hs.hotkey.bind(super, "Up", function()
    local win = hs.window.focusedWindow()
    win:toggleFullScreen()
end)

hs.hotkey.bind(super, "Left", function()
    local win = hs.window.focusedWindow()
    if false == win:isFullScreen() then
        win:moveToUnit( hs.layout.left50 )
    end
end)

hs.hotkey.bind(super, "Right", function()
    local win = hs.window.focusedWindow()
    if false == win:isFullScreen() then
        win:moveToUnit( hs.layout.right50 )
    end
end)

hs.hotkey.bind(super, "Down", function()
    local win = hs.window.focusedWindow()
    if false == win:isFullScreen() then
        win:maximize()
    end
end)

hs.hotkey.bind(super, "escape", function()
	hs.alert.show('Looking busy', 0.5)
    local helium = hs.application.find('Helium')
    if helium then
        helium:kill()
    end
    local audio = hs.audiodevice.defaultOutputDevice()
    if audio then
        audio:setMuted(true)
    end
    hs.application.launchOrFocus(editor)
    local win = hs.window.focusedWindow()
    if false == win:isFullScreen() then
        win:maximize()
    end
end)


function setupDevelopmentEnvironment()
    hs.application.launchOrFocus(mail)
    local win = hs.window.focusedWindow()
    -- win:setFullScreen(false)
    win:setFullScreen(true)
    hs.application.launchOrFocus(todo)
    local win = hs.window.focusedWindow()
    -- win:setFullScreen(false)
    win:setFullScreen(true)
    hs.application.launchOrFocus(terminal)
    local win = hs.window.focusedWindow()
    -- win:setFullScreen(false)
    win:setFullScreen(true)
    hs.application.launchOrFocus(browser)
    local win = hs.window.focusedWindow()
    -- win:setFullScreen(false)
    win:setFullScreen(true)
    hs.application.launchOrFocus(editor)
    local win = hs.window.focusedWindow()
    -- win:setFullScreen(false)
    win:setFullScreen(true)
end

hs.hotkey.bind(super_shift, "D", function()
    setupDevelopmentEnvironment()
end)

-- Replace Caffeine.app with 18 lines of Lua :D
local caffeine = hs.menubar.new()

function setCaffeineDisplay(state)
    local result
    if state then
        result = caffeine:setIcon("caffeine-on.pdf")
    else
        result = caffeine:setIcon("caffeine-off.pdf")
    end
end

function caffeineClicked()
    setCaffeineDisplay(hs.caffeinate.toggle("displayIdle"))
end

if caffeine then
    caffeine:setClickCallback(caffeineClicked)
    setCaffeineDisplay(hs.caffeinate.get("displayIdle"))
end
