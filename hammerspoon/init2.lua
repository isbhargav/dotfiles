require("modules.clipboard")
require("modules.choose-browser")
require("modules.anycomplete")
-- require("modules.control-escape")

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



