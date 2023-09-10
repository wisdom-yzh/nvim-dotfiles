local _M = {}

_M.load = function (use)
    use {
        "nvim-neotest/neotest",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",

            "nvim-neotest/neotest-go",
            "rouge8/neotest-rust"
            -- Your other test adapters here
        }
    }
end

_M.run = function ()
    -- get neotest namespace (api call creates or returns namespace)
    local neotest_ns = vim.api.nvim_create_namespace("neotest")
    vim.diagnostic.config({
        virtual_text = {
            format = function(diagnostic)
                local message =
                diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
                return message
            end,
        },
    }, neotest_ns)

    require "neotest".setup({
        -- your neotest config here
        adapters = {
            require("neotest-go")({
                args = { "-timeout=60s", "-race" }
            }),
            require("neotest-rust") {
                args = { "--no-capture" },
            }
        },
    })

    vim.cmd  [[ 
        nnoremap <leader>t :lua require("neotest").run.run()<CR>
        nnoremap <leader>T :lua require("neotest").run.run(vim.fn.expand("%"))<CR>
    ]]
end

return _M
