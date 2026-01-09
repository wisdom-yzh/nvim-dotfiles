local vim = vim
local _M = {}

_M.load = function (use)
    use 'Mofiqul/vscode.nvim'
end

local color_schemas = {
    "light",
    "dark",
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
    local c = require('vscode.colors').get_colors()

    vscode.setup({
        -- Enable transparent background
        transparent = false,

        -- Enable italic comment
        italic_comments = true,

        -- Underline `@markup.link.*` variants
        underline_links = true,

        -- Disable nvim-tree background color
        disable_nvimtree_bg = true,

        -- Override highlight groups (see ./lua/vscode/theme.lua)
        group_overrides = {
            -- this supports the same val table as vim.api.nvim_set_hl
            -- use colors from this colorscheme by requiring vscode.colors!
            Cursor = { fg=c.vscDarkBlue, bg=c.vscLightGreen, bold=true },
        }
    })
    vscode.load(color_schemas[color_idx])
    vim.cmd [[
        nnoremap <silent><C-x> <Cmd>:lua SWITCH_COLORSCHEMA()<CR>
    ]]
end

return _M
