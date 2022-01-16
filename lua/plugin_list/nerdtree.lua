local vim = vim
local _M = {}

_M.load = function (use)
    use {
        'preservim/nerdtree',
        requires = {
            'ryanoasis/vim-webdevicons'
        }
    }
end

_M.run = function ()
    vim.cmd [[
        map <leader><leader> :NERDTreeToggle<CR>
        map <leader>. :NERDTreeFind<CR>
    ]]
end

return _M
