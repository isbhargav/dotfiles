require("modules.clipboard")
require("modules.choose-browser")
require("modules.anycomplete")
require("modules.volume")
require("modules.brightness")
require("modules.bluetooth-control")
require('modules.capslock')

-- disable animationDuration
hs.window.animationDuration = 0

--
-- Reloading of the config file
--

local psuSerial = 'C061083PT0RPM0RAS'
if hs.battery.psuSerialString() == psuSerial then
  print("Serial Match")
end
function reload_config(files)
    hs.reload()
end
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reload_config):start()
hs.notify.new({
  title="Hammerspoon",
  informativeText="Config Reload Success",
  withdrawAfter=1,
}):send()


