-- Author: Yifattih
-- ===========================================================================
-- FLOATING TERMINAL
-- ===========================================================================

local terminal = require("utils.floating_terminal")
local termina_runner = require("utils.floating_terminal_runner")

local opts = {
    noremap = true,
    silent = true
}

-- Run file in floating terminal
vim.keymap.set(
    "n",
    "<leader>run",
    termina_runner.run_current_file,
    {
        desc = "Run current file in floating terminal"
    }
)

vim.keymap.set(
    "n",
    "<leader>term",
    terminal.toggle,
    opts,
    {
        desc = "Toggle floating terminal"
    }
)

vim.keymap.set(
    "t",
    "<Esc>",
    terminal.close,
    opts,
    {
        desc = "Close floating terminal from terminal mode"
    }
)
