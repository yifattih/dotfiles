return {
  "f3fora/cmp-spell",
  enabled = true,
  ft = { "markdown", "text", "gitcommit" }, -- Enable only for writing-related filetypes
  config = function()
    vim.opt.spell = true        -- Enable spelling
    vim.opt.spelllang = { "en" } -- Set to your desired language (can be a list)
  end,
}
