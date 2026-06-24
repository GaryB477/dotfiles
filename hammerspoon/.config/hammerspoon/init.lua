hs = hs
local log = hs.logger.new('AAppWinSize', 'debug')
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "W", function()
  hs.notify.new({title="Hammerspoon", informativeText="Hello World"}):send()
end)


-- Launches/focuses an app. If the app is already frontmost, cycles through
-- all its windows instead (works across multiple screens/spaces).
local function launchOrCycle(appName)
    return function()
        local front = hs.application.frontmostApplication()
        if front and front:name() == appName then
            -- App already active: rotate to the next window.
            local windows = front:visibleWindows()
            -- Keep only standard windows and sort them for a stable order.
            local standard = {}
            for _, w in ipairs(windows) do
                if w:isStandard() then
                    table.insert(standard, w)
                end
            end
            table.sort(standard, function(a, b) return a:id() < b:id() end)

            if #standard > 1 then
                local focused = hs.window.focusedWindow()
                local idx = 1
                for i, w in ipairs(standard) do
                    if focused and w:id() == focused:id() then
                        idx = i
                        break
                    end
                end
                local nextWin = standard[(idx % #standard) + 1]
                nextWin:focus()
                return
            end
        end
        hs.application.launchOrFocus(appName)
    end
end

hs.hotkey.bind({"alt"}, "D", launchOrCycle("Visual Studio Code"))
hs.hotkey.bind({"alt"}, "F", launchOrCycle("Google Chrome"))
hs.hotkey.bind({"alt"}, "L", launchOrCycle("Ghostty"))
hs.hotkey.bind({"alt"}, "M", launchOrCycle("Microsoft Teams"))
hs.hotkey.bind({"alt"}, "N", launchOrCycle("Obsidian"))
hs.hotkey.bind({"alt"}, "J", launchOrCycle("Rider"))
hs.hotkey.bind({"alt"}, "K", launchOrCycle("Gitkraken"))
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

