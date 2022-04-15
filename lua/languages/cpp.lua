local _M = {}

_M.lsp = function ()
    return {}
end

_M.dap = function ()
	return {
        {
            name = "Launch file",
            type = "cpptools",
            request = "launch",
            miDebuggerPath = "/usr/bin/gdb",
            program = function()
                return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = true,
            setupCommands = {
                {
                    text = '-enable-pretty-printing',
                    description =  'enable pretty printing',
                    ignoreFailures = false
                },
            },
        }
    }
end

_M.lint = function ()
    return {
        liners = {
            'cpplint',
        },
        fixers = {
            'clang-format'
        }
    }
end

return _M
