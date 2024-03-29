local _M = {}

local plugins = {
    "plugin_list.tree",
    "plugin_list.colorschema",
    "plugin_list.fuzzy_search",
    "plugin_list.syntax_highlight",
    "plugin_list.lsp",
    "plugin_list.autocomplete",
    "plugin_list.statusline",
    "plugin_list.tabline",
    "plugin_list.git",
    "plugin_list.dap",
    "plugin_list.editor",
    "plugin_list.lint",
    "plugin_list.term",
    "plugin_list.scroll",
    "plugin_list.unit_test",
}

_M.load = function (use)
    for _, plugin in ipairs(plugins) do
        require(plugin).load(use)
    end
end

_M.run = function ()
    for _, plugin in ipairs(plugins) do
        require(plugin).run()
    end
end

return _M
