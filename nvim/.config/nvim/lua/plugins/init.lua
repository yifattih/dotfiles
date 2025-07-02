local plugins = {}
local plugin_dir = "plugins"  -- because it's inside `lua/plugins/`
local plugin_files = vim.fn.readdir(vim.fn.stdpath("config") .. "/lua/" .. plugin_dir)

for _, file in ipairs(plugin_files) do
  if file:match("%.lua$") and file ~= "init.lua" then
    local module_name = plugin_dir .. "." .. file:gsub("%.lua$", "")
    local ok, plugin = pcall(require, module_name)
    if ok then
      table.insert(plugins, plugin)
    else
      vim.notify("Error loading plugin file: " .. module_name, vim.log.levels.ERROR)
    end
  end
end

return plugins
