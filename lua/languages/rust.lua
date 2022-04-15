local _M = {}

_M.lsp = function ()
    return {}
end

_M.dap = function ()
    return require("languages/cpp").dap
end

_M.lint = function ()
    vim.cmd [[
        let g:ale_rust_cargo_use_clippy = executable('cargo-clippy')

        let b:rust_default_edition = '2018'
        let b:rust_edition = trim(system('cargo get --edition 2>/dev/null'))
        if v:shell_error > 0 || len(b:rust_edition) == 0
            let b:rust_edition = b:rust_default_edition
        endif
        let g:ale_rust_rustfmt_options = '--edition ' .. b:rust_edition
    ]]
    return {
        liners = { "cargo" },
        fixers = { "rustfmt" }
    }
end

return _M
