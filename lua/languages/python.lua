local _M = {}

_M.lsp = function ()
    return {
        settings = {
            ty = {
                -- ty language server settings go here
            }
        }
    }
end

_M.lint = function ()
    return {
        linters = {
            "ruff"
        },
        fixers = {
            'ruff', 'isort', 'black'
        }
    }
end

return _M
