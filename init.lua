require "options"
require "plugins"
if not (#vim.v.argv == 2 and vim.v.argv[2] == "+PackerSync") then
    require "plugin_list".run()
end
