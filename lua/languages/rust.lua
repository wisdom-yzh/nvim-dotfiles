local _M = {}

_M.lsp = function ()
    return {
        settings = {
            ["rust-analyzer"] = {
                imports = {
                    granularity = {
                        group = "module",
                    },
                    prefix = "self",
                },
                cargo = {
                    buildScripts = {
                        enable = true,
                    },
                },
                procMacro = {
                    enable = true,
                },
                diagnostics = {
                    experimental = {
                        enable = true
                    }
                }
            },
        },
    }
end

_M.lint = function ()
    vim.cmd [[
        let g:ale_rust_cargo_use_clippy = executable('cargo-clippy')

        let b:rust_default_edition = '2021'
        let b:rust_edition = trim(system('cargo get --edition 2>/dev/null'))
        if v:shell_error > 0 || len(b:rust_edition) == 0
            let b:rust_edition = b:rust_default_edition
        endif
        let g:ale_rust_rustfmt_options = '--edition ' .. b:rust_edition
    ]]
    return {
        linters = { "cargo" },
        fixers = { "rustfmt" }
    }
end

return _M
