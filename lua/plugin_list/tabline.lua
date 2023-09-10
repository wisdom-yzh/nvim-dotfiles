local vim = vim
local _M = {}

_M.load = function (use)
    use {
        "akinsho/bufferline.nvim",
        requires = {
             'kyazdani42/nvim-web-devicons',
        },
    }
end

_M.run = function ()
    vim.opt.termguicolors = true
    require("bufferline").setup {
        options = {
            diagnostics = "nvim_lsp",
            sort_by = 'insert_after_current'
        },
    }
    vim.cmd [[
        nnoremap <C-k> :BufferLineCycleNext<CR>
        nnoremap <C-j> :BufferLineCyclePrev<CR>

        nnoremap <silent><leader>1 <Cmd>BufferLineGoToBuffer 1<CR>
        nnoremap <silent><leader>2 <Cmd>BufferLineGoToBuffer 2<CR>
        nnoremap <silent><leader>3 <Cmd>BufferLineGoToBuffer 3<CR>
        nnoremap <silent><leader>4 <Cmd>BufferLineGoToBuffer 4<CR>
        nnoremap <silent><leader>5 <Cmd>BufferLineGoToBuffer 5<CR>
        nnoremap <silent><leader>6 <Cmd>BufferLineGoToBuffer 6<CR>
        nnoremap <silent><leader>7 <Cmd>BufferLineGoToBuffer 7<CR>
        nnoremap <silent><leader>8 <Cmd>BufferLineGoToBuffer 8<CR>
        nnoremap <silent><leader>9 <Cmd>BufferLineGoToBuffer 9<CR>

        nnoremap \d :BufferLineCyclePrev<cr>:bd #<cr>
        nnoremap \v :vert sb #<cr>
    ]]
end

return _M
