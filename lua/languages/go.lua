local _M = {}

_M.lsp = function ()
    return {}
end

_M.dap = function ()
    return {
        {
            type = "go",
            name = "Debug",
            request = "launch",
            showLog = false,
            program = "${file}",
            dlvToolPath = vim.fn.exepath("dlv"), -- Adjust to where delve is installed
        },
    }
end

return _M
