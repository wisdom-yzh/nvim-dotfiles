local vim = vim
local _M = {}

_M.load = function (use)
    use {
        "folke/tokyonight.nvim"
    }
end

local color_schemas = {
    "tokyonight-day",
    "tokyonight",
    "tokyonight-moon",
    "tokyonight-night",
}
local color_idx = 1
function SWITCH_COLORSCHEMA()
    color_idx = (color_idx % #color_schemas) + 1
    vim.cmd("colorscheme " .. color_schemas[color_idx])
end

_M.run = function ()
    vim.cmd [[
        colorscheme tokyonight-day
        nnoremap <silent><C-x> <Cmd>:lua SWITCH_COLORSCHEMA()<CR>
    ]]
end

return _M
