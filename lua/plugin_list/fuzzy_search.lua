local vim = vim
local _M = {}

_M.load = function (use)
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
            { 'nvim-tree/nvim-web-devicons' },
        }
    }
end

_M.run = function ()
    vim.cmd [[
        nnoremap <silent> <C-c> :vimgrep <cword> %<CR> :cw <CR>
        nnoremap <silent> <C-p> :Telescope find_files<CR>
        nnoremap <silent> <M-p> :Telescope live_grep<CR>
        nnoremap <silent> <S-p> :Telescope grep_string<CR>
    ]]

    local actions = require("telescope.actions")
    local telescope = require("telescope")
    telescope.setup({
        defaults = {
            mappings = {
                i = {
                    ["<M-a>"] =  actions.send_to_qflist + actions.open_qflist,
                }
            }
        },
        pickers = {
            -- Default configuration for builtin pickers goes here:
            -- picker_name = {
            --   picker_config_key = value,
            --   ...
            -- }
            -- Now the picker_config_key will be applied every time you call this
            -- builtin picker
        },
        extensions = {
            fzf = {
                fuzzy = true,                    -- false will only do exact matching
                override_generic_sorter = true,  -- override the generic sorter
                override_file_sorter = true,     -- override the file sorter
                case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                -- the default case_mode is "smart_case"
            }
            -- Your extension configuration goes here:
            -- extension_name = {
            --   extension_config_key = value,
            -- }
            -- please take a look at the readme of the extension you want to configure
        }
    })
    telescope.load_extension('fzf')
end

return _M
