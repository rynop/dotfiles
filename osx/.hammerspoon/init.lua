-- Options
HYPER_KEYS = {"alt", "cmd"}

-- Reload configuration when config file changes
-- Does not work if config is stored in Dropbox
hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

-- Allow for window moving and resizing
hs.loadSpoon("MiroWindowsManager")
hs.window.animationDuration = 0

spoon.MiroWindowsManager:bindHotkeys({
    up = {HYPER_KEYS, "up"},
    right = {HYPER_KEYS, "right"},
    down = {HYPER_KEYS, "down"},
    left = {HYPER_KEYS, "left"},
    fullscreen = {HYPER_KEYS, "x"}
})

spoon.MiroWindowsManager.fullScreenSizes = {
    1, 10/9
}

-- Allow bouncing to different screens
-- hs.loadSpoon("WindowScreenLeftAndRight")
-- spoon.WindowScreenLeftAndRight:bindHotkeys({
--     screen_left = {{"ctrl", "alt", "cmd"}, "Left"},
--     screen_right = {{"ctrl", "alt", "cmd"}, "Right"}
-- })

hs.loadSpoon("WinWin")
hs.hotkey.bind({"ctrl", "alt", "cmd"}, "Left", function() spoon.WinWin:moveToScreen("left") end)
hs.hotkey.bind({"ctrl", "alt", "cmd"}, "Right", function() spoon.WinWin:moveToScreen("right") end)
hs.hotkey.bind({"ctrl", "alt", "cmd"}, "Up", function() spoon.WinWin:moveToScreen("up") end)
hs.hotkey.bind({"ctrl", "alt", "cmd"}, "Down", function() spoon.WinWin:moveToScreen("down") end)

-- Sleep prevention
-- hs.loadSpoon("Caffeine")
-- spoon.Caffeine:start()

-- Focus shortcuts -- Eventually this will be its own Spoon
-- alt is option on macOS
-- hs.hotkey.bind({"alt"}, "1", function () hs.application.launchOrFocus("iTerm") end)
hs.hotkey.bind({"alt"}, "1", function () hs.application.launchOrFocus("Warp") end)
--hs.hotkey.bind({"alt"}, "2", function() hs.application.launchOrFocus("Visual Studio Code") end)
hs.hotkey.bind({"alt"}, "2", function() hs.application.launchOrFocus("Cursor") end)
hs.hotkey.bind({"alt"}, "4", function() hs.application.launchOrFocus("Slack") end)
-- hs.hotkey.bind({"alt"}, "5", function() os.execute("/Applications/Firefox.app/Contents/MacOS/firefox-bin -P &") end)
hs.hotkey.bind({"shift", "ctrl", "alt"}, "space", function() hs.application.launchOrFocus("Slack") end)
hs.hotkey.bind({"cmd"}, "f8", function() hs.application.launchOrFocus("Spotify") end)


-- Tagline to show that the configuration was reloaded
hs.alert.show("Hammerspoon reloaded")
