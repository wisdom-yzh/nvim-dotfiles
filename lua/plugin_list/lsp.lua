local vim = vim
local _M = {}

local function map_lsp_keybindings(buf_set_keymap)
    local opts = { noremap=true, silent=true }

    buf_set_keymap('n', '<leader>c', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', '<leader>d', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', '<leader><s-d>', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<leader><s-c>', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<leader><c-c>', '<cmd> Lspsaga incoming_calls<CR>', opts)
    buf_set_keymap('n', '<leader><c-v>', '<cmd> Lspsaga outgoing_calls<CR>', opts)
    buf_set_keymap('n', '<leader>w', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
    buf_set_keymap('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
end

_M.load = function (use)
    use {
        "williamboman/mason.nvim",
        run = ":MasonUpdate",

        'neovim/nvim-lspconfig',
        "williamboman/mason-lspconfig.nvim",
        'nvimdev/lspsaga.nvim',
    }
end

_M.run = function ()
    require("mason").setup({
        ui = {
            icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗"
            }
        }
    })

    local mason_lsp = require("mason-lspconfig")

    local server_configs = {
        lua_ls = require "languages.lua",
        clangd = require "languages.cpp",
        ts_ls = require "languages.typescript",
        gopls = require "languages.go",
        rust_analyzer = require "languages.rust",
        jsonls = require "languages.json",
        pyright = require "languages.python",
    }

    local lsp_config = require("lspconfig")
    mason_lsp.setup_handlers({
        function(svr)
            local opts = server_configs[svr]
            if opts ~= nil and opts.lsp ~= nil then
                opts = opts.lsp()
            end
            if opts == nil then
                opts = {}
            end
            opts.capabilities = require 'cmp_nvim_lsp'.default_capabilities()
            opts.on_attach = function (client, bufnr)
                local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
                map_lsp_keybindings(buf_set_keymap)
                if client.server_capabilities.inlayHintProvider then
                    vim.lsp.inlay_hint.enable()
                end
            end
            lsp_config[svr].setup(opts)
        end,
    })

    mason_lsp.setup {
        ensure_installed = {
            "lua_ls",
            "clangd",
            "ts_ls",
            "gopls",
            "rust_analyzer",
            "jsonls",
            "pyright",
            "bashls",
            "dockerls",
            "yamlls",
        },
    }

    require('lspsaga').setup({
        lightbulb = {
            enable = false,
        },
        symbol_in_winbar = {
            enable = false,
        },
    })
end

return _M
