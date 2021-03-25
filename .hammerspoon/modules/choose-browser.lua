-- 
-- Browser Menu
--

-- Step 1: Take care, that Hammerspoon is the default browser
if hs.urlevent.getDefaultHandler("http") ~= "org.hammerspoon.hammerspoon" then
    hs.urlevent.setDefaultHandler("http")
end

-- Step 2: Setup the browser menu table

local available_browsers = {
    {['text'] = "Safari",['subText'] = "Safari",['command'] = "com.apple.safari",['image'] = hs.image.imageFromPath(os.getenv("HOME") .. "/.hammerspoon/browsermenu/safari.png")},
    {['text'] = "Firefox",['subText'] = "Firefox",['command'] = "org.mozilla.firefox",['image'] = hs.image.imageFromPath(os.getenv("HOME") .. "/.hammerspoon/browsermenu/firefox.png")},
    {['text'] = "Google Chrome",['subText'] = "Google Chrome",['command'] = "com.apple.safari",['image'] = hs.image.imageFromPath(os.getenv("HOME") .. "/.hammerspoon/browsermenu/chrome.png")},
    {['text'] = "Brave",['subText'] = "Brave",['command'] = "com.brave.Browser",['image'] = hs.image.imageFromPath(os.getenv("HOME") .. "/.hammerspoon/browsermenu/brave.png")},
}

-- Focus the last used window.
local function focusLastFocused()
    local wf = hs.window.filter
    local lastFocused = wf.defaultCurrentSpace:getWindows(wf.sortByFocusedLast)
    if #lastFocused > 0 then lastFocused[1]:focus() end
end

-- Step 2: Register callback
hs.urlevent.httpCallback = function(scheme, host, params, fullURL)
    if host == nil then
        host = 'file'
    end
    -- Closure over fullURL that is passed to browser
    local choose_browser = hs.chooser.new(function(choice)
        if not choice then focusLastFocused(); return end
        local app = choice.command
        hs.urlevent.openURLWithBundle(fullURL, app)
    end)
    choose_browser:rows(#available_browsers)
    choose_browser:choices(available_browsers)
    choose_browser:show()

end

