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
        highlights = {
            fill = {
                fg = { attribute = "fg", highlight = "Normal" },
                bg = { attribute = "bg", highlight = "StatusLineNC" },
            },
            background = {
                fg = { attribute = "fg", highlight = "Normal" },
                bg = { attribute = "bg", highlight = "StatusLine" },
            },
            buffer_visible = {
                fg = { attribute = "fg", highlight = "Normal" },
                bg = { attribute = "bg", highlight = "Normal" },
            },
            buffer_selected = {
                fg = { attribute = "fg", highlight = "Normal" },
                bg = { attribute = "bg", highlight = "Normal" },
            },
            separator = {
                fg = { attribute = "bg", highlight = "Normal" },
                bg = { attribute = "bg", highlight = "StatusLine" },
            },
            separator_selected = {
                fg = { attribute = "fg", highlight = "Special" },
                bg = { attribute = "bg", highlight = "Normal" },
            },
            separator_visible = {
                fg = { attribute = "fg", highlight = "Normal" },
                bg = { attribute = "bg", highlight = "StatusLineNC" },
            },
            close_button = {
                fg = { attribute = "fg", highlight = "Normal" },
                bg = { attribute = "bg", highlight = "StatusLine" },
            },
            close_button_selected = {
                fg = { attribute = "fg", highlight = "Normal" },
                bg = { attribute = "bg", highlight = "Normal" },
            },
            close_button_visible = {
                fg = { attribute = "fg", highlight = "Normal" },
                bg = { attribute = "bg", highlight = "Normal" },
            },
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
