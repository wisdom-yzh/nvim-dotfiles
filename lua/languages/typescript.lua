local _M = {}

_M.lsp = function ()
    return {}
end

_M.dap = function ()
	return {
        {
            name = "Launch",
            type = "node2",
            request = "launch",
            program = function()
                return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end,
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
            protocol = "inspector",
            console = "integratedTerminal",
        },
        {
            -- For this to work you need to make sure the node process is started with the `--inspect` flag.
            name = 'Attach to process',
            type = 'node2',
            request = 'attach',
            port = 9229,
            processId = require'dap.utils'.pick_process,
        }
    }
end

_M.lint = function ()
    return {
        liners = {
            'eslint',
            'prettier',
        },
        fixers = {
            'eslint',
            'prettier',
        }
    }
end

return _M
