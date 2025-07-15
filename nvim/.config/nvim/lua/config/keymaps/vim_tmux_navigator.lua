-- Author: Yifattih
-- ==========================================================================
-- VIM TMUX NAVIGATOR KEYMAPS
-- ==========================================================================

vim.keymap.set(
    "n",
    "<C-h>",
    "<cmd><C-U>TmuxNavigateLeft<CR>",
    {
        desc = "Focus Window Left"
    }
)

vim.keymap.set(
    "n",
    "<C-j>",
    "<cmd><C-U>TmuxNavigateDown<CR>",
    { desc = "Focus window down" }
)

vim.keymap.set(
    "n",
    "<C-k>",
    "<cmd><C-U>TmuxNavigateUp<CR>",
    {
        desc = "Focus window up"
    }
)

vim.keymap.set(
    "n",
    "<C-l>",
    "<cmd><C-U>TmuxNavigateRight<CR>",
    {
        desc = "Focus window right"
    }
)

vim.keymap.set(
    "n",
    "<C-\\>",
    "<cmd><C-U>TmuxNavigatePrevious<CR>",
    {
        desc = "Focus previous window"
    }
)
