local _M = {}

_M.lsp = function ()
    return {}
end

_M.dap = function ()
    return require("languages/cpp").dap
end

return _M
