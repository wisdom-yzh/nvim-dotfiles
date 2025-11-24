local vim = vim
local _M = {}

_M.load = function (use)
    use {
        'tpope/vim-fugitive',
        'lewis6991/gitsigns.nvim',
        requires = {
          'nvim-lua/plenary.nvim'
        },
    }
end

_M.run = function ()
    require('gitsigns').setup({
        current_line_blame = true
    })
    vim.cmd [[
        nmap <leader>gg :Git<CR>
        nmap <leader>gl :Gclog %<CR>
        nmap <leader>gb :Git blame<CR>:Lspsaga winbar_toggle<CR>
    ]]
end

return _M