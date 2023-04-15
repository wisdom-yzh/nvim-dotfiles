local _M = {}

_M.lsp = function ()
    return {}
end

_M.dap = function ()
    return {
        {
            type = 'python',
            request = 'launch',
            name = "Launch file",
            program = "${file}",
        }
    }
end

_M.lint = function ()
    return {}
end

return _M
