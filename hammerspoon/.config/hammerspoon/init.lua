hs = hs
local log = hs.logger.new('AAppWinSize', 'debug')
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "W", function()
  hs.notify.new({title="Hammerspoon", informativeText="Hello World"}):send()
end)


hs.hotkey.bind({"alt"}, "D", function()
   hs.application.launchOrFocus("Visual Studio Code")
end)
hs.hotkey.bind({"alt"}, "F", function()
   hs.application.launchOrFocus("Google Chrome")
end)
hs.hotkey.bind({"alt"}, "L", function()
   hs.application.launchOrFocus("Ghostty")
end)
hs.hotkey.bind({"alt"}, "M", function()
   hs.application.launchOrFocus("Microsoft Teams")
end)
  hs.hotkey.bind({"alt"}, "N", function()
   hs.application.launchOrFocus("Obsidian")
end)
hs.hotkey.bind({"alt"}, "J", function()
   hs.application.launchOrFocus("Rider")
end)
hs.hotkey.bind({"alt"}, "K", function()
   hs.application.launchOrFocus("Gitkraken")
end)
hs.hotkey.bind({"alt"}, "H", function()
    local app = hs.application.frontmostApplication()
    if app then
        app:hide()
    end
end)
hs.hotkey.bind({"cmd", "alt"}, "R", function()
   hs.reload()
end)

  -- Higher order function that prevents animations from interfering with resizing.
local function adjustWindowSettings(action)
    -- Temporarily disable EnhancedUserInterface to prevent window animations
    -- (see https://github.com/Hammerspoon/hammerspoon/issues/3224#issuecomment-1294359070)
    local axApp = hs.axuielement.applicationElement(hs.window.frontmostWindow():application())
    local wasEnhanced = axApp.AXEnhancedUserInterface
    axApp.AXEnhancedUserInterface = false

    -- Temporarily disable window animations
    local originalAnimationDuration = hs.window.animationDuration
    hs.window.animationDuration = 0

    action()

    -- Restore the original settings
    hs.window.animationDuration = originalAnimationDuration
    axApp.AXEnhancedUserInterface = wasEnhanced
end

-- Get the display name for logging
local function getDisplayName(app, title)
    -- Use "app: title" format if title exists and is different from app name,
    -- otherwise just use "app"
    return (title ~= "" and title ~= app) and (app .. ": " .. title) or app
end

-- Maximizes the currently focused window to fill the entire screen.
local function maximizeCurrentWindow()
    adjustWindowSettings(function()
        log.d('Starting maximizeCurrentWindow')
        local window = hs.window.focusedWindow()
        if not window then
            log.d('No window is currently focused.')
            return
        end
        local screen = window:screen()
        local usableFrame = screen:frame() -- Usable screen area excluding dock and menu bar.
        local displayName = getDisplayName(window:application():name(), window:title())
        log.d('Attempting to maximize current window: ' .. displayName)
        window:setFrame(usableFrame)
        log.d('Finished maximizeCurrentWindow.')
    end)
end

local function centerWindow()
    adjustWindowSettings(function()
        log.d('Starting minimizeCurrentWindow')
        local window = hs.window.focusedWindow()
        if not window then
            log.d('No window is currently focused.')
            return
        end

        local frame = window:frame()
        local screen = window:screen()
        local max = screen:frame()
        frame.w = max.w * 0.5
        frame.h = max.h * 0.7
        frame.x = max.x + (max.w - frame.w) / 2
        frame.y = max.y + (max.h - frame.h) / 2

        local displayName = getDisplayName(window:application():name(), window:title())
        log.d('Minimizing current window: ' .. displayName)
        window:setFrame(frame)
        log.d('Finished minimizeCurrentWindow.')
    end)
end

-- Minimizes the currently focused window to % of the screen size and centers it.
local function moveWindowLeft50()
    adjustWindowSettings(function()
        log.d('Starting minimizeCurrentWindow')
        local window = hs.window.focusedWindow()
        if not window then
            log.d('No window is currently focused.')
            return
        end

        local frame = window:frame()
        local screen = window:screen()
        local max = screen:frame()
        frame.w = max.w * 0.5
        frame.h = max.h * 1.0
        --frame.x = max.x + (max.w - frame.w) / 2
        --frame.y = max.y + (max.h - frame.h) / 2
        frame.x = 0
        frame.y = 0

        local displayName = getDisplayName(window:application():name(), window:title())
        log.d('Minimizing current window: ' .. displayName)
        window:setFrame(frame)
        log.d('Finished minimizeCurrentWindow.')
    end)
end

local function moveWindowRight50()
    adjustWindowSettings(function()
        log.d('Starting minimizeCurrentWindow')
        local window = hs.window.focusedWindow()
        if not window then
            log.d('No window is currently focused.')
            return
        end

        local frame = window:frame()
        local screen = window:screen()
        local max = screen:frame()
        frame.w = max.w * 0.5
        frame.h = max.h * 1.0
        frame.x = max.w / 2
        frame.y = 0

        local displayName = getDisplayName(window:application():name(), window:title())
        log.d('Minimizing current window: ' .. displayName)
        window:setFrame(frame)
        log.d('Finished minimizeCurrentWindow.')
    end)
end
hs.hotkey.bind({ "alt" }, "left",  moveWindowLeft50)
hs.hotkey.bind({ "alt" }, "right",  moveWindowRight50)
hs.hotkey.bind({ "alt" }, "up",  maximizeCurrentWindow)
hs.hotkey.bind({ "alt" }, "down",  centerWindow)

