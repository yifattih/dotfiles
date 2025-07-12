-- Author: Yifattih
-- ===========================================================================
-- COLORSCHEME & TRANSPARENCY
-- ===========================================================================

-- Color Scheme
vim.cmd.colorscheme("unokai")

-- Transparency
vim.api.nvim_set_hl(
    0,
    "Normal",
    {
        bg = "none"
    }
)

vim.api.nvim_set_hl(
    0,
    "NormalNC",
    {
        bg = "none"
    }
)

vim.api.nvim_set_hl(
    0,
    "EndOfBuffer",
    {
        bg = "none"
    }
)
