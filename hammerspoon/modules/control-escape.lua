-- Sends "escape" if "caps lock" is held for less than .2 seconds, and no other keys are pressed.
-- Remap capslock to escape 

-- local send_escape = false
-- local last_mods = {}
-- local control_key_timer = hs.timer.delayed.new(0.2, function()
--     send_escape = false
-- end)

-- hs.eventtap.new({hs.eventtap.event.types.flagsChanged}, function(evt)
--     local new_mods = evt:getFlags()
--     if last_mods["ctrl"] == new_mods["ctrl"] then
--       return false
--     end
--     if not last_mods["ctrl"] then
--       last_mods = new_mods
--       send_escape = true
--       control_key_timer:start()
--     else
--         if send_escape then
--           print("escape")
--           hs.eventtap.keyStroke({}, "escape")
--         end
--         last_mods = new_mods
--         control_key_timer:stop()
--     end
--     return false
-- end):start()












-- send_escape = false
-- last_mods = {}

-- control_key_handler = function()
--   send_escape = false
-- end

-- control_key_timer = hs.timer.delayed.new(0.15, control_key_handler)

-- control_handler = function(evt)
--   local new_mods = evt:getFlags()
--   if last_mods["ctrl"] == new_mods["ctrl"] then
--     return false
--   end
--   if not last_mods["ctrl"] then
--     last_mods = new_mods
--     send_escape = true
--     control_key_timer:start()
--   else
--     last_mods = new_mods
--     control_key_timer:stop()
--     if send_escape then
--       return true, {
--         hs.eventtap.event.newKeyEvent({}, 'escape', true),
--         hs.eventtap.event.newKeyEvent({}, 'escape', false),
--       }
--     end
--   end
--   return false
-- end

-- control_tap = hs.eventtap.new({hs.eventtap.event.types.flagsChanged}, control_handler)
-- control_tap:start()

-- other_handler = function(evt)
--   send_escape = false
--   return false
-- end

-- other_tap = hs.eventtap.new({hs.eventtap.event.types.keyDown}, other_handler)
-- other_tap:start()
