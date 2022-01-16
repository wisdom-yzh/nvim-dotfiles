local vim = vim
local _M = {}

_M.load = function (use)
    use {
        "sainnhe/sonokai",
        { as = "sonokai" }
    }
end

_M.run = function ()
    vim.cmd [[
        set t_Co=256
        set background=dark
        colorscheme sonokai
    ]]
end

return _M
