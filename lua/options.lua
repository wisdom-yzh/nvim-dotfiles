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
    termencoding = "utf-8",
    autoindent = true,
    cindent = true,
    expandtab = true,
    tabstop = 4,
    softtabstop = 4,
    shiftwidth = 4,
    t_ut = "",
}

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

bind_option(global_options)

return {}
