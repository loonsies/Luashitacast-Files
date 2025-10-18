local settings = require('settings')

local config = {}

local default = T {
    scale = { 1.0 },
    locked = { false },
    hidden = { false },
    centered = { false }
}

config.load = function ()
    return settings.load(default)
end

return config
