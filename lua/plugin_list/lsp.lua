local vim = vim
local _M = {}

local function install_lsp_servers(config, installer)
    for name, _ in pairs(config) do
        local server_is_found, server = installer.get_server(name)
        if server_is_found then
            if not server:is_installed() then
                print("Installing " .. name)
                server:install()
            end
        end
    end
end

local function map_lsp_keybindings(buf_set_keymap)
    local opts = { noremap=true, silent=true }

    buf_set_keymap('n', '<leader>c', ':vsplit<CR><cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', '<leader>d', ':vsplit<CR><cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', '<leader><s-d>', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<leader><s-c>', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<leader>w', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
    buf_set_keymap('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
end

_M.load = function (use)
    use {
        'neovim/nvim-lspconfig',
        'williamboman/nvim-lsp-installer',
    }
end

_M.run = function ()
    local lsp_installer = require("nvim-lsp-installer")

    lsp_installer.settings({
        ui = {
            icons = {
                server_installed = "✓",
                server_pending = "➜",
                server_uninstalled = "✗"
            }
        }
    })

    local lsp_config = {
        sumneko_lua = require "languages.lua",
        clangd = require "languages.cpp",
        tsserver = require "languages.typescript",
        gopls = require "languages.go",
        rust_analyzer = require "languages.rust",
        jsonls = require "languages.json"
    }

    install_lsp_servers(lsp_config, lsp_installer)

    -- Register a handler that will be called for all installed servers.
    -- Alternatively, you may also register handlers on specific server instances instead (see example below).
    lsp_installer.on_server_ready(function(server)
        local opts = lsp_config[server.name].lsp()

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require'cmp_nvim_lsp'.update_capabilities(capabilities)

        if opts then
            -- (optional) Customize the options passed to the server
            opts.on_attach = function(_, bufnr)
                local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
                map_lsp_keybindings(buf_set_keymap)
            end

            opts.capabilities = capabilities

            -- This setup() function is exactly the same as lspconfig's setup function.
            -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
            server:setup(opts)
        end
    end)
end

return _M
