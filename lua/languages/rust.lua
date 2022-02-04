local _M = {}

_M.lsp = function ()
    return {}
end

_M.dap = function ()
    return require("languages/cpp").dap
end

_M.lint = function ()
    return {
        liners = { "cargo" },
        fixers = { "rustfmt" }
    }
end

return _M
