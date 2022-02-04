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
        {
            type = "go",
            name = "Attach",
            mode = "local",
            request = "attach",
            processId = require('dap.utils').pick_process,
            dlvToolPath = vim.fn.exepath("dlv"), -- Adjust to where delve is installed
        },
        {
            type = "go",
            name = "Debug test",
            request = "launch",
            mode = "test",
            program = "${file}",
            dlvToolPath = vim.fn.exepath("dlv"), -- Adjust to where delve is installed
        },
        {
            type = "go",
            name = "Debug test (go.mod)",
            request = "launch",
            mode = "test",
            program = "./${relativeFileDirname}",
            dlvToolPath = vim.fn.exepath("dlv"), -- Adjust to where delve is installed
        }
    }
end

_M.lint = function ()
    return {
        liners = {
            "gofmt"
        },
        fixers = {
            "gofmt"
        }
    }
end

return _M
