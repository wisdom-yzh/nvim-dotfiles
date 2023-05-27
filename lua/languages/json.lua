local _M = {}

_M.lsp = function ()
    -- Enable (broadcasting) snippet capability for completion
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    return {
        settings = {
            json = {
                schemas = {
                    {
                        fileMatch = {"package.json"},
                        url = "https://json.schemastore.org/package.json"
                    },
                    {
                        fileMatch = {"tsconfig*.json"},
                        url = "https://json.schemastore.org/tsconfig.json"
                    },
                    {
                        fileMatch = {
                            ".prettierrc",
                            ".prettierrc.json",
                            "prettier.config.json"
                        },
                        url = "https://json.schemastore.org/prettierrc.json"
                    },
                    {
                        fileMatch = {".eslintrc", ".eslintrc.json"},
                        url = "https://json.schemastore.org/eslintrc.json"
                    },
                    {
                        fileMatch = {".babelrc", ".babelrc.json", "babel.config.json"},
                        url = "https://json.schemastore.org/babelrc.json"
                    },
                    {
                        fileMatch = {"lerna.json"},
                        url = "https://json.schemastore.org/lerna.json"
                    },
                    {
                        fileMatch = {"now.json", "vercel.json"},
                        url = "https://json.schemastore.org/now.json"
                    },
                    {
                        fileMatch = {
                            ".stylelintrc",
                            ".stylelintrc.json",
                            "stylelint.config.json"
                        },
                        url = "http://json.schemastore.org/stylelintrc.json"
                    }
                }
            }
        },
        capabilities = capabilities,
    }
end

_M.lint = function ()
    return {
        linters = { "eslint" },
        fixers = { "eslint" },
    }
end

return _M
