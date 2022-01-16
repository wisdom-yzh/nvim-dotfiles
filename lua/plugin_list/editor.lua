local _M = {}

_M.load = function (use)
    use {
        'editorconfig/editorconfig-vim',
        'terryma/vim-multiple-cursors',
        'Raimondi/delimitMate',
    }
end

_M.run = function ()
    vim.g['EditorConfig_max_line_indicator'] = 'none'
end

return _M
