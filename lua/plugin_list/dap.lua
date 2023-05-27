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
        }
    })
    dapUi()
    dapKeyBindings()
end

return _M
