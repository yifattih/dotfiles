-- Author: Yifattih
-- A good portion of this configuration comes from:
-- https://github.com/radleylewis/nvim-lite/blob/youtube_demo/init.lua
-- ===========================================================================
-- WHICH-KEY MENU COLORS
-- ===========================================================================

-- Manual highlight override to match unokai style
vim.api.nvim_set_hl(
    0,
    "WhichKey",
    {
        fg = "#fab387",
        bold = true
    }
)

vim.api.nvim_set_hl(
    0,
    "WhichKeyGroup",
    {
        fg = "#89b4fa",
        bold = true
    }
)

vim.api.nvim_set_hl(
    0,
    "WhichKeyDesc",
    {
        fg = "#f9e2af"
    }
)

vim.api.nvim_set_hl(
    0,
    "WhichKeyFloat",
    {
        bg = "none"
    }
)

vim.api.nvim_set_hl(
    0,
    "WhichKeySeparator",
    {
        fg = "#89b4fa"
    }
)
