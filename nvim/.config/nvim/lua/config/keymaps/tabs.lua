-- Author: Yifattih
-- ===========================================================================
-- TABS
-- ===========================================================================

local tabs = require("utils.tabs")

local opts = {
    noremap = true,
    silent = true
}

-- Tabs navigation
vim.keymap.set(
    'n',
    '<leader>tn',
    ':tabnew<CR>',
    opts,
    {
        desc = 'New tab'
    }
)

vim.keymap.set(
    'n',
    '<leader>tx',
    ':tabclose<CR>',
    opts,
    {
        desc = 'Close tab'
    }
)

vim.keymap.set(
    'n',
    '<Tab>',
    'gt',
    opts,
    {
        desc = "Move to next tab"
    }
)

vim.keymap.set(
    'n',
    '<S-Tab>',
    'gT',
    {
        desc = "Go to previous tab"
    }
)

vim.keymap.set(
    'n',
    '<leader>t>',
    ':tabmove +1<CR>',
    opts,
    {
        desc = 'Move tab right'
    }
)

vim.keymap.set(
    'n',
    '<leader>t<',
    ':tabmove -1<CR>',
    opts,
    {
        desc = 'Move tab left'
    }
)

-- Enhanced keybindings
vim.keymap.set(
    'n',
    '<leader>tO',
    tabs.open_file_in_tab,
    {
        desc = 'Open file in new tab'
    }
)

vim.keymap.set(
    'n',
    '<leader>td',
    tabs.duplicate_tab,
    {
        desc = 'Duplicate current tab'
    }
)
