local vim = vim
local _M = {}

local function dapKeyBindings()
    vim.cmd [[
        nnoremap <leader>b :lua require('dap').toggle_breakpoint()<CR>
        nnoremap <leader>r :lua require('dap').continue()<CR>
        nnoremap <leader><S-r> :lua require('dap').terminate()<CR>:lua require('dapui').toggle()<CR>
        nnoremap <leader>n :lua require('dap').step_over()<CR>
        nnoremap <leader>s :lua require('dap').step_into()<CR>
        nnoremap <leader><S-s> :lua require('dap').step_out()<CR>
        nnoremap <leader>p :lua require('dap.ui.widgets').hover()<CR>
    ]]
end

local function dapUi()
    local dap, dapui = require("dap"), require("dapui")

    vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})

    -- nvim-dap-virtual-text. Show virtual text for current frame
    require("nvim-dap-virtual-text").setup()
    vim.g.dap_virtual_text = true
    dap.defaults.fallback.terminal_win_cmd = "10new"

    dapui.setup({
        icons = { expanded = "▾", collapsed = "▸" },
        mappings = {
            -- Use a table to apply multiple mappings
            expand = { "<CR>", "<2-LeftMouse>" },
            open = "o",
            remove = "d",
            edit = "e",
            repl = "r",
        },
        layouts = {
            {
                -- You can change the order of elements in the sidebar
                elements = {
                    -- Provide as ID strings or tables with "id" and "size" keys
                    {
                        id = "scopes",
                        size = 0.25, -- Can be float or integer > 1
                    },
                    { id = "breakpoints", size = 0.25 },
                    { id = "stacks", size = 0.25 },
                    { id = "watches", size = 00.25 },
                },
                size = 40,
                position = "left", -- Can be "left", "right", "top", "bottom"
            },
            {
                elements = { "repl", "console" },
                size = 100,
                position = "right", -- Can be "left", "right", "top", "bottom"
            },
        },
        floating = {
            max_height = nil, -- These can be integers or a float between 0 and 1.
            max_width = nil, -- Floats will be treated as percentage of your screen.
            border = "single", -- Border style. Can be "single", "double" or "rounded"
            mappings = {
                close = { "q", "<Esc>" },
            },
        },
        windows = { indent = 1 },
    })

    dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
    end
end

_M.load = function (use)
    use {
        "williamboman/mason.nvim",
        "mfussenegger/nvim-dap",
        "jay-babu/mason-nvim-dap.nvim",

        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",
        
        "nvim-neotest/nvim-nio"
    }
end

_M.run = function ()
    require("mason").setup()
    require("mason-nvim-dap").setup({
        ensure_installed = { "delve", "python", "cppdbg", "node2", "bash" },
        automatic_installation = true,
        handlers = {
            function (config)
                require('mason-nvim-dap').default_setup(config)
            end,
            cppdbg = function (config)
                config.configurations = {
                    {
                        name = 'Launch file',
                        type = 'cppdbg',
                        request = 'launch',
                        program = function()
                            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                        end,
                        cwd = '${workspaceFolder}',
                        stopAtEntry = true,
                        setupCommands = {
                            {
                                text = '-enable-pretty-printing',
                                description =  'enable pretty printing',
                                ignoreFailures = false
                            },
                        },
                    },
                    {
                        name = 'Attach to gdbserver :1234',
                        type = 'cppdbg',
                        request = 'launch',
                        MIMode = 'gdb',
                        miDebuggerServerAddress = 'localhost:1234',
                        miDebuggerPath = vim.fn.exepath('gdb'),
                        cwd = '${workspaceFolder}',
                        program = function()
                            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                        end,
                        setupCommands = {
                            {
                                text = '-enable-pretty-printing',
                                description =  'enable pretty printing',
                                ignoreFailures = false
                            },
                        },
                    },
                }
                require('mason-nvim-dap').default_setup(config)
            end,
            delve = function (config)
                config.configurations = {
                    {
                        type = "delve",
                        name = "Debug",
                        request = "launch",
                        showLog = false,
                        program = "./${relativeFileDirname}",
                        dlvToolPath = vim.fn.exepath("dlv"), -- Adjust to where delve is installed
                    },
                    {
                        type = "delve",
                        name = "Debug test",
                        request = "launch",
                        mode = "test",
                        program = "./${relativeFileDirname}",
                        dlvToolPath = vim.fn.exepath("dlv"), -- Adjust to where delve is installed
                    },
                    {
                        type = "delve",
                        name = "Debug test function",
                        request = "launch",
                        mode = "test",
                        program = "./${relativeFileDirname}",
                        args = function ()
                            return {"-test.run", vim.fn.input("test function: ")}
                        end,
                        dlvToolPath = vim.fn.exepath("dlv"), -- Adjust to where delve is installed
                    },
                }
                require('mason-nvim-dap').default_setup(config)
            end,
            python = function (config)
                local venv_path = os.getenv('VIRTUAL_ENV') or os.getenv('CONDA_PREFIX')
                config.configurations = {
                    {
                        -- The first three options are required by nvim-dap
                        type = 'python', -- the type here established the link to the adapter definition: `dap.adapters.python`
                        request = 'launch',
                        name = 'Python: Launch file',
                        program = '${file}', -- This configuration will launch the current file if used.
                        -- venv on Windows uses Scripts instead of bin
                        pythonPath = venv_path
                            and ((vim.fn.has('win32') == 1 and venv_path .. '/Scripts/python') or venv_path .. '/bin/python')
                            or nil,
                        console = 'integratedTerminal',
                    },
                    {
                        type = 'python',
                        request = 'launch',
                        name = 'Run pytest - 当前文件',
                        module = 'pytest',
                        args = { '${file}' },
                        pythonPath = function()
                            local cwd = vim.fn.getcwd()
                            if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
                                return cwd .. '/venv/bin/python'
                            elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
                                return cwd .. '/.venv/bin/python'
                            else
                                return '/usr/bin/python3'
                            end
                        end,
                    },
                    {
                        type = 'python',
                        request = 'launch',
                        name = 'Run pytest - 当前函数',
                        module = 'pytest',
                        args = function()
                            local file = vim.fn.expand('%:p')
                            local line = vim.fn.line('.')
                            -- 获取当前函数名
                            local func_name = vim.fn.searchpairpos('def\\s\\+\\([a-zA-Z_0-9]\\+\\)\\s*(', '', ')', 'bW')
                            if func_name[1] > 0 then
                                local func_line = func_name[1]
                                local func_text = vim.fn.getline(func_line)
                                local _, _, name = string.find(func_text, 'def\\s\\+\\([a-zA-Z_0-9]\\+\\)\\s*(')
                                if name then
                                    return { file .. '::' .. name }
                                end
                            end
                            -- 如果没找到函数名，就只运行文件
                            return { file }
                        end,
                        pythonPath = function()
                            -- 虚拟环境检测逻辑
                            local cwd = vim.fn.getcwd()
                            if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
                                return cwd .. '/venv/bin/python'
                            elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
                                return cwd .. '/.venv/bin/python'
                            else
                                return '/usr/bin/python3'
                            end
                        end,
                    }
                }
                require('mason-nvim-dap').default_setup(config)
            end
        }
    })
    dapUi()
    dapKeyBindings()
end

return _M
