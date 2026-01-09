local vim = vim
local _M = {}

_M.load = function (use)
    use {
        'nvim-treesitter/nvim-treesitter',
        branch = 'main',
        run = ':TSUpdate'
    }
end

_M.run = function ()
    -- require('nvim-treesitter.configs').setup{
    --     ensure_installed = "all",

    --     -- Install languages synchronously (only applied to `ensure_installed`)
    --     sync_install = false,

    --     highlight = {
    --         enable = true,
    --         additional_vim_regex_highlighting = false,
    --     },

    --     indent = {
    --         enable = true,
    --     },
    -- }
    vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
            local treesitter = require('nvim-treesitter')
            local lang = vim.treesitter.language.get_lang(args.match)
            if vim.list_contains(treesitter.get_available(), lang) then
                if not vim.list_contains(treesitter.get_installed(), lang) then
                    treesitter.install(lang):wait()
                end
                vim.treesitter.start(args.buf)
            end
        end,
        desc = "Enable nvim-treesitter and install parser if not installed"
    })

    vim.wo.foldmethod = 'expr'
    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.wo.foldlevel = 99
    -- vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
    -- vim.wo.foldmethod = 'expr'
end

return _M
