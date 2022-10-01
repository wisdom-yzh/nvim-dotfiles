local vim = vim
local _M = {}

_M.load = function (use)
    use {
        "folke/tokyonight.nvim"
    }
end

_M.run = function ()
    vim.cmd [[
        colorscheme tokyonight-day
    ]]
end

return _M
