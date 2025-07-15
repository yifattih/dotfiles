-- Author: Yifattih
-- ==========================================================================
-- MARKVIEW
-- ==========================================================================

-- Markview and text editing
vim.keymap.set(
    "n",
    "<leader>mr",
    ":Markview splitToggle<CR>",
    {
        desc = "Toggle markup split preview"
    }
)

-- Quick config editing
vim.keymap.set(
    "n",
    "<leader>rc",
    ":e ~/.config/nvim/init.lua<CR>",
    {
        desc = "Edit config"
    }
)
