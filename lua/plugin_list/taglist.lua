local vim = vim
local _M = {}

_M.load = function (use)
    use {
        'liuchengxu/vista.vim',
    }
end

_M.run = function ()
    vim.g.vista_default_executive = "nvim_lsp"
    vim.cmd [[
        " map keybindings
        nmap <leader>t :Vista!!<CR>
    ]]
end

return _M
