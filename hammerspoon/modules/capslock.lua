
-- Ctrl+Cmd+Alt + P -- Toggle Caps Lock
hs.hotkey.bind({"ctrl", "cmd", "alt"}, "P", function()
  hs.hid.capslock.toggle()
  local status = hs.hid.capslock.get()
  hs.alert.show("Capslock: " .. (status and "OFF" or"ON" ))
end)
--
--
-- local iconAscii = [[ASCII:
-- ............
-- .....J......
-- ............
-- ............
-- KL........HI
-- ............
-- ............
-- .F........G.
-- ............
-- ............
-- .D........C.
-- ............
-- .A........B.
-- ............
-- ]]

-- local function onClick()
--     -- hs.application.launchOrFocus('Slack')
--     return function()
--       hs.hid.capslock.toggle() 

--       -- hs.alert.show("Pressed") 
--     end
-- end

-- local menu = hs.menubar.new():setClickCallback(onClick()):setIcon(iconAscii)
