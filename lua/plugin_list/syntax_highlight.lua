local vim = vim
local _M = {}

_M.load = function (use)
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
end

_M.run = function ()
    require('nvim-treesitter.configs').setup{
        -- One of "all", "maintained" (parsers with maintainers), or a list of languages
        ensure_installed = "maintained",

        -- Install languages synchronously (only applied to `ensure_installed`)
        sync_install = false,

        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        indent = {
            enable = true,
        },
    }

    vim.wo.foldmethod = 'expr'
    vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
    vim.wo.foldlevel = 1
end

return _M
