local vim = vim
local _M = {}

_M.load = function (use)
    use {
        'liuchengxu/vista.vim',
    }
end

_M.run = function ()
    vim.cmd [[
        " map keybindings
        nmap <leader>t :Vista!!<CR>
    ]]
end

return _M
