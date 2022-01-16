local _M = {}

_M.load = function (use)
    use {
        'dense-analysis/ale',
    }
end

_M.run = function ()
    vim.cmd [[
        let g:ale_linters = {
        \'html': [],
        \'javascript': ['eslint'],
        \'typescript': ['eslint', 'prettier', 'tsserver'],
        \'typescriptreact': ['eslint', 'prettier', 'tsserver'],
        \'python': ['pyflakes'],
        \'c': [],
        \'cpp': []
        \}

        let g:ale_fixers = {
        \'javascript': ['eslint'],
        \'typescript': ['eslint', 'prettier'],
        \'typescriptreact': ['eslint', 'prettier'],
        \'*': ['remove_trailing_lines', 'trim_whitespace']
        \}

        let g:ale_php_phpcs_standard = 'PSR2'
        let g:airline#extensions#ale#enabled = 1
        let g:ale_sign_error = '!>'
        let g:ale_sign_warning = '?>'
        let g:ale_echo_msg_error_str = 'Error'
        let g:ale_echo_msg_warning_str = 'Warning'
        let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
        let g:ale_open_list = 0
        let g:ale_keep_list_window_open = 0
        let g:ale_set_quickfix = 0
        let g:ale_set_loclist = 1
        let g:ale_lint_on_text_changed = 'never'
        let g:ale_fix_on_save = 1
    ]]
end

return _M