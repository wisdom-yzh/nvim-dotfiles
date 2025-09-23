local vim = vim
local cmd = vim.cmd

local global_options = {
    mouse = "a",
    compatible = false,
    foldenable = true,
    foldmethod= "indent",
    foldlevelstart = 99,
    cul	= true,
    shortmess = "atI",
    backspace = 2,
    number = true,
    rnu = true,
    helplang = "cn",
    noeb = true,
    confirm = true,
    autoread = true,
    hlsearch = true,
    incsearch = true,
    laststatus = 2,
    backupcopy = "yes",
    lazyredraw = true,
    tags = "./tags;,tags",
    updatetime = 3000,
    backup = false,
    writebackup = false,
    hidden = true,
    encoding = "utf-8",
    fileencodings = "ucs-bom,utf-8,cp936",
    fileencoding = "utf-8",
    -- termencoding = "utf-8",
    autoindent = true,
    cindent = true,
    expandtab = true,
    tabstop = 4,
    softtabstop = 4,
    shiftwidth = 4,
    t_ut = "",
    cmdheight = 0,
}

local global_vars = {
    mapleader = ","
}

local function bind_vars(options)
    for k, v in pairs(options) do
        vim.g[k] = v
    end
end

local function bind_option(options)
    for k, v in pairs(options) do
        if v == true then
            cmd("set " .. k)
        elseif v == false then
            cmd("set no" .. k)
        else
            cmd("set " .. k .. "=" .. v)
        end
    end
end

local function wsl_bind_clipboard()
    vim.cmd [[
        if system('uname -r') =~ "microsoft"
            let s:clip = '/mnt/c/Windows/System32/clip.exe'  " default location
            if executable(s:clip)
                augroup WSLYank
                    autocmd!
                    autocmd TextYankPost * call system('echo '.shellescape(join(v:event.regcontents, "\<CR>")).' | '.s:clip)
                augroup END
            end
        end
    ]]
end

-- migrate from my old .vimrc
local function old_filetype_options()
    vim.cmd [[
        autocmd Filetype cpp setlocal ts=2 sts=2 sw=2
        autocmd Filetype css setlocal ts=2 sts=2 sw=2
        autocmd Filetype scss setlocal ts=2 sts=2 sw=2
        autocmd Filetype html setlocal ts=2 sts=2 sw=2
        autocmd Filetype phtml setlocal ts=2 sts=2 sw=2
        autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
        autocmd Filetype typescript setlocal ts=2 sts=2 sw=2
        autocmd Filetype javascriptreact setlocal ts=2 sts=2 sw=2
        autocmd Filetype typescriptreact setlocal ts=2 sts=2 sw=2

        au BufRead,BufNewFile *.{css,less} set ft=css
        au BufRead,BufNewFile *.{xml,ejs} set ft=html
        au BufRead,BufNewFile *.vue set ft=vue
    ]]
end

bind_option(global_options)
bind_vars(global_vars)
wsl_bind_clipboard()
old_filetype_options()
return {}
