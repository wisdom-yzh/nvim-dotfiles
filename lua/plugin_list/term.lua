local _M = {}
local vim = vim

_M.load = function (use)
    use {
        "akinsho/toggleterm.nvim"
    }
end

_M.run = function ()
    require "toggleterm".setup {
        size = function()
            return vim.o.columns * 0.3
        end,
        direction = "vertical",
    }

    vim.cmd [[
        autocmd TermEnter term://*toggleterm#*
            \ tnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>

        nnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>
        inoremap <silent><c-t> <Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>

        nnoremap 2<silent><c-t> <Cmd>exe v:count2 . "ToggleTerm"<CR>
        nnoremap 3<silent><c-t> <Cmd>exe v:count3 . "ToggleTerm"<CR>
        nnoremap 4<silent><c-t> <Cmd>exe v:count4 . "ToggleTerm"<CR>
        nnoremap 5<silent><c-t> <Cmd>exe v:count5 . "ToggleTerm"<CR>
    ]]
end

return _M
