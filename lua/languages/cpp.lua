local _M = {}

_M.lsp = function ()
    return {}
end

_M.lint = function ()
    vim.g.ale_c_clangformat_use_local_file = 1

    return {
        linters = {
            'clangtidy',
        },
        fixers = {
            'clang-format'
        }
    }
end

return _M
