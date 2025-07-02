-- ALE settings
vim.g.ale_fix_on_save = 1
vim.g.ale_fixers = {
  python = { "black" },
  sh = { "shfmt" },
  terraform = { "terraform" }
}

-- Python indentation
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
  end,
})
