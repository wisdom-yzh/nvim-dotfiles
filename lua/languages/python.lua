local _M = {}

_M.lsp = function ()
    return {}
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
