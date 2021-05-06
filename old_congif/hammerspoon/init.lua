require("modules.clipboard")
require("modules.choose-browser")
require("modules.anycomplete")

-- disable animationDuration
hs.window.animationDuration = 0

--
-- Reloading of the config file
--

function reload_config(files)
    hs.reload()
end
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reload_config):start()
hs.notify.new({
  title="Hammerspoon",
  informativeText="Config Reload Success",
  withdrawAfter=1,
}):send()
-- 
-- Clipboard History menu : Cmd+Shift+v
--
-- clipboard_menu = hs.chooser.new(function (choice)
--     if choice then
--         hs.pasteboard.setContents(choice.content)
--         hs.eventtap.keyStroke({ "cmd" }, "v")
--     end
-- end)

-- local history = {}
-- function addHistoryFromPasteboard()
--     local contentTypes = hs.pasteboard.contentTypes()

--     local item = {}
--     for index, uti in ipairs(contentTypes) do
--         if uti == "public.utf8-plain-text" then
--             local text = hs.pasteboard.readString()
--             item.text = string.gsub(text, "[\r\n]+", " ")
--             item.content = text;
--             break
--         end
--     end

--     table.insert(history, 1, item)
-- end

-- local preChangeCount = hs.pasteboard.changeCount()
-- local watcher = hs.timer.new(0.5, function ()
--     local changeCount = hs.pasteboard.changeCount()
--     if preChangeCount ~= changeCount then
--         addHistoryFromPasteboard()
--         preChangeCount = changeCount
--     end
-- end)
-- watcher:start()

-- hs.hotkey.bind({ "cmd", "shift" }, "v", function ()
--     clipboard_menu:choices(history)
--     clipboard_menu:show()
-- end)


-- 
-- Browser Menu
--

-- -- Step 1: Take care, that Hammerspoon is the default browser
-- if hs.urlevent.getDefaultHandler("http") ~= "org.hammerspoon.hammerspoon" then
--     hs.urlevent.setDefaultHandler("http")
-- end

-- -- Step 2: Setup the browser menu table

-- local available_browsers = {
--     {['text'] = "Safari",['subText'] = "Safari",['command'] = "com.apple.safari",['image'] = hs.image.imageFromPath(os.getenv("HOME") .. "/.hammerspoon/browsermenu/safari.png")},
--     {['text'] = "Firefox",['subText'] = "Firefox",['command'] = "org.mozilla.firefox",['image'] = hs.image.imageFromPath(os.getenv("HOME") .. "/.hammerspoon/browsermenu/firefox.png")},
--     {['text'] = "Google Chrome",['subText'] = "Google Chrome",['command'] = "com.apple.safari",['image'] = hs.image.imageFromPath(os.getenv("HOME") .. "/.hammerspoon/browsermenu/chrome.png")},
--     {['text'] = "Brave",['subText'] = "Brave",['command'] = "com.brave.Browser",['image'] = hs.image.imageFromPath(os.getenv("HOME") .. "/.hammerspoon/browsermenu/brave.png")},
-- }

-- -- Focus the last used window.
-- local function focusLastFocused()
--     local wf = hs.window.filter
--     local lastFocused = wf.defaultCurrentSpace:getWindows(wf.sortByFocusedLast)
--     if #lastFocused > 0 then lastFocused[1]:focus() end
-- end

-- -- Step 2: Register callback
-- hs.urlevent.httpCallback = function(scheme, host, params, fullURL)
--     if host == nil then
--         host = 'file'
--     end
--     -- Closure over fullURL that is passed to browser
--     choose_browser = hs.chooser.new(function(choice)
--         if not choice then focusLastFocused(); return end
--         app = choice.command
--         hs.urlevent.openURLWithBundle(fullURL, app)
--     end)
--     choose_browser:rows(#available_browsers)
--     choose_browser:choices(available_browsers)
--     choose_browser:show()

-- end
