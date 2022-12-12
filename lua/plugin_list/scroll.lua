local require = require
local _M = {}

_M.load = function (use)
    use {
        'karb94/neoscroll.nvim',
    }
end

_M.run = function ()
    require "neoscroll".setup()
end

return _M
