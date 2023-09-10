local vim = vim
local _M = {}

_M.load = function (use)
    use 'Mofiqul/vscode.nvim'
end

local color_schemas = {
    "dark",
    "light"
}

local color_idx = 1
function SWITCH_COLORSCHEMA()
    color_idx = (color_idx % #color_schemas) + 1
    local color = color_schemas[color_idx]
    vim.o.background = color
    require('vscode').load(color)
end

_M.run = function ()
    local vscode = require('vscode')
    vscode.setup()
    vscode.load(color_schemas[color_idx])
    vim.cmd [[
        nnoremap <silent><C-x> <Cmd>:lua SWITCH_COLORSCHEMA()<CR>
    ]]
end

return _M
