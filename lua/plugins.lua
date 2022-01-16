local vim = vim

vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function (use)
    use 'wbthomason/packer.nvim'
    require("plugin_list").load(use)
end)

