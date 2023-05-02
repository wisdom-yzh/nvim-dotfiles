local _M = {}
local vim = vim

_M.load = function (use)
    use {
        "akinsho/toggleterm.nvim"
    }
end

function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

_M.run = function ()
    require "toggleterm".setup {
        size = function()
            return 40
        end,
        direction = "horizontal",
        auto_scroll = false,
        start_in_insert = true,
        winbar = {
            enabled = false,
        },
    }

    vim.cmd [[
        autocmd! TermOpen term://* lua set_terminal_keymaps()

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
