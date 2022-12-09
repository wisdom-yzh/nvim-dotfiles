local vim = vim
local _M = {}

_M.load = function (use)
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional, for file icons
        },
        tag = 'nightly' -- optional, updated every week. (see issue #1193)

    }
end

_M.run = function ()
    -- disable netrw at the very start of your init.lua (strongly advised)
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    vim.opt.termguicolors = true

    require("nvim-tree").setup({
        sort_by = "case_sensitive",
        view = {
            adaptive_size = true,
            mappings = {
                list = {
                    { key = "u", action = "dir_up" },
                    { key = "s", action = "vsplit" },
                    { key = "p", action = "parent_node" },
                    { key = "<C-j>", action = "next_sibling" },
                    { key = "<C-k>", action = "prev_sibling" },
                },
            },
        },
        renderer = {
            group_empty = true,
        },
        filters = {
            dotfiles = true,
        },
        actions = {
            change_dir = {
                enable = true,
                global = true,
                restrict_above_cwd = false,
            },
        }
    })

    vim.cmd [[
        map <leader><leader> :NvimTreeToggle<CR>
        map <leader>. :NvimTreeFindFile<CR>
    ]]
end

return _M
