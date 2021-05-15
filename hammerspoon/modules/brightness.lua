function changeBrightness(diff)
  return function()
    local current = hs.brightness.get()
    local new = math.min(100, math.max(0, math.floor(current + diff)))
    hs.alert.closeAll(0.0)
    hs.alert.show("Brightness " .. new .. "%", {}, 0.5)
    hs.brightness.set(new)
  end
end

-- Increment/Decrement 3 steps 
hs.hotkey.bind({ 'alt', 'cmd'}, 'Down', changeBrightness(-3))
hs.hotkey.bind({ 'alt', 'cmd'}, 'Up', changeBrightness(3))

-- Increment/Decrement 20 steps 
hs.hotkey.bind({ 'alt', 'cmd'}, '=', changeBrightness(10))
hs.hotkey.bind({ 'alt', 'cmd'}, '-', changeBrightness(-10))
