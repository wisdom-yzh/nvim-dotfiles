local vim = vim
local _M = {}

local function map_lsp_keybindings()
    local opts = { noremap=true, silent=true }

    vim.keymap.set('n', '<leader>c', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.keymap.set('n', '<leader>d', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.keymap.set('n', '<leader><s-d>', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.keymap.set('n', '<leader><s-c>', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.keymap.set('n', '<leader><c-c>', '<cmd> Lspsaga incoming_calls<CR>', opts)
    vim.keymap.set('n', '<leader><c-v>', '<cmd> Lspsaga outgoing_calls<CR>', opts)
    vim.keymap.set('n', '<leader>w', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
    vim.keymap.set('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    vim.keymap.set('n', '<leader>m', '<cmd>Lspsaga outline<CR>', opts)
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
        ty = require "languages.python",
    }

    mason_lsp.setup {
        automatic_enable = true,
        ensure_installed = {
            "lua_ls",
            "clangd",
            "ts_ls",
            "gopls",
            "rust_analyzer",
            "jsonls",
            "ty",
            "bashls",
            "dockerls",
            "yamlls",
        }
    }

    vim.lsp.config("*", {
        capabilities = require 'cmp_nvim_lsp'.default_capabilities()
    })

    vim.lsp.inlay_hint.enable()

    for k, v in pairs(server_configs) do
        vim.lsp.config(k, v.lsp())
        local base_on_attach = vim.lsp.config[k].on_attach
        vim.lsp.config(k, {
            on_attach = function(client, bufnr)
                if base_on_attach then
                    base_on_attach(client, bufnr)
                end
            end,
        })
    end

    require('lspsaga').setup({
        lightbulb = {
            enable = false,
        },
        symbol_in_winbar = {
            enable = true,
        },
        implement = {
            enable = true,
            sign = true,
        },
        outline = {
            win_width = 60,
        }
    })

    map_lsp_keybindings()
end

return _M
