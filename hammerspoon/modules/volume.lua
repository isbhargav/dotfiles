
function changeVolume(diff)
  return function()
    local current = hs.audiodevice.defaultOutputDevice():volume()
    local new = math.min(100, math.max(0, math.floor(current + diff)))
    if new > 0 then
      hs.audiodevice.defaultOutputDevice():setMuted(false)
    end
    hs.alert.closeAll(0.0)
    hs.alert.show("Volume " .. new .. "%", {}, 0.5)
    hs.audiodevice.defaultOutputDevice():setVolume(new)
  end
end

-- Increment/Decrement 3 steps 
hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, 'Down', changeVolume(-3))
hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, 'Up', changeVolume(3))

-- Increment/Decrement 20 steps 
hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, '=', changeVolume(20))
hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, '-', changeVolume(-20))

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "W", function()
  hs.alert.show("Hello World!")
end)
-- function test()
--   return function()
--     -- hs.hid.capslock.toggle() 
--     print("Hello")
--   end
-- end

-- hs.hotkey.bind({'cmd'}, 'w', test())
