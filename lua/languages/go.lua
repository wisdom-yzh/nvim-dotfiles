local _M = {}

_M.lsp = function ()
    return {
        settings = {
            gopls = {
                hints = {
                    assignVariableTypes = true,
                    compositeLiteralFields = true,
                    compositeLiteralTypes = true,
                    constantValues = true,
                    functionTypeParameters = true,
                    parameterNames = true,
                    rangeVariableTypes = true,
                },
            },
        },
    }
end

_M.lint = function ()
    return {
        linters = {
            "gofmt"
        },
        fixers = {
            "gofmt"
        }
    }
end

return _M
