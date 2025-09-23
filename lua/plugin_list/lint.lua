local _M = {}

_M.load = function (use)
    use {
        'dense-analysis/ale',
    }
end

_M.run = function ()
    -- LSP is enabled by nvim-lsp, so we do not use LSP linters in ALE
    vim.g.ale_disable_lsp = 1
    vim.g.ale_linters_explicit = 1
    vim.g.ale_sign_error = '!>'
    vim.g.ale_sign_warning = '?>'
    vim.g.ale_echo_msg_error_str = 'Error'
    vim.g.ale_echo_msg_warning_str = 'Warning'
    vim.g.ale_echo_msg_format = '[%linter%] %s [%severity%]'
    vim.g.ale_open_list = 0
    vim.g.ale_keep_list_window_open = 0
    vim.g.ale_set_quickfix = 0
    vim.g.ale_set_loclist = 1
    vim.g.ale_lint_on_save = 1
    vim.g.ale_python_ruff_options = '--fix --exit-non-zero-on-fix'
    vim.g.ale_fix_on_save = 1

    local ts = require("languages/typescript").lint()
    local cpp = require("languages/cpp").lint()
    local json = require("languages/json").lint()
    local go = require("languages/go").lint()
    local lua = require("languages/lua").lint()
    local rust = require("languages/rust").lint()
    local python = require("languages/python").lint()

    vim.g.ale_linters = {
        javascript = ts.linters,
        typescript = ts.linters,
        javascriptreact = ts.linters,
        typescriptreact = ts.linters,
        json = json.linters,
        go = go.linters,
        rust = rust.linters,
        c = cpp.linters,
        cpp = cpp.linters,
        lua = lua.linters,
        python = python.linters,
    }

    vim.g.ale_fixers = {
        javascript = ts.fixers,
        typescript = ts.fixers,
        javascriptreact = ts.fixers,
        typescriptreact = ts.fixers,
        json = json.fixers,
        go = go.fixers,
        rust = rust.fixers,
        c = cpp.fixers,
        cpp = cpp.fixers,
        lua = lua.fixers,
        python = python.fixers,
        ["*"] = {"remove_trailing_lines", "trim_whitespace"},
    }
end

return _M
