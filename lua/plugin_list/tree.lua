local vim = vim
local _M = {}

_M.load = function (use)
    use {
        'nvim-tree/nvim-tree.lua',       -- file tree
        'simrat39/symbols-outline.nvim', -- symbol tree
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional, for file icons
        },
    }
end

local function on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set('n', 'p',       api.node.navigate.parent,        opts('up'))
  vim.keymap.set('n', '<C-j>',   api.node.navigate.sibling.next,  opts('next'))
  vim.keymap.set('n', '<C-k>',   api.node.navigate.sibling.prev,  opts('prev'))
  vim.keymap.set('n', '<M-k>',   api.node.navigate.sibling.first, opts('next'))
  vim.keymap.set('n', '<M-j>',   api.node.navigate.sibling.last,  opts('prev'))
  vim.keymap.set('n', 's',       api.node.open.vertical,          opts('vsplit'))
  vim.keymap.set('n', 'u',       api.tree.change_root_to_parent,  opts('dir up'))
end


_M.run = function ()
    -- disable netrw at the very start of your init.lua (strongly advised)
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    vim.opt.termguicolors = true

    require("nvim-tree").setup({
        sort_by = "case_sensitive",
        on_attach = on_attach,
        view = {
            adaptive_size = true,
        },
        update_focused_file = {
            enable = false,
            update_root = true,
            ignore_list = {},
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
        },
        diagnostics = {
            enable = true,
        }
    })

    require("symbols-outline").setup()

    vim.cmd [[
        map <leader><leader> :NvimTreeToggle<CR>
        map <leader>. :NvimTreeFindFile<CR>
        map <leader>m :SymbolsOutline<CR>
        
        nnoremap \d :bd<cr>
        nnoremap \v :vertical sb #<cr>
        nnoremap \h :horizontal sb #<cr>
    ]]
end

return _M
