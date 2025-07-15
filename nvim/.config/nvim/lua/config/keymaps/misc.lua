-- Author: Yifattih
-- Some parts of this configuration comes from:
-- https://github.com/radleylewis/nvim-lite/blob/youtube_demo/init.lua
-- ===========================================================================
-- GENERAL KEYMAPS
-- ===========================================================================

local opts = {
    noremap = true,
    silent = true
}

-- Leader
vim.g.mapleader = " "      -- Set leader key to space

vim.g.maplocalleader = " " -- Set local leader key to space (NEW)

vim.keymap.set(
    "n",
    "<Space>",
    "<Nop>",
    opts,
    {
        desc = "Disable spacebar in normal mode"
    }
)

-- Copy Full File-Path
vim.keymap.set(
    "n",
    "<leader>pa",
    function()
        local path = vim.fn.expand("%:p")
        vim.fn.setreg("+", path)
        print("file:", path)
    end
)

-- Escape
vim.keymap.set(
    "i",
    "jj",
    "<ESC>",
    opts,
    {
        desc = "Set insert mode escape to jj"
    }
)

-- Enable external copy & paste using native buffers
vim.keymap.set(
    {
        'n',
        'v'
    },
    '<C-c>',
    '"+y',
    opts,
    {
        desc = "Yank or copy to system clipboard"
    }
)

vim.keymap.set(
    {
        'n',
        'v'
    },
    '<C-p>',
    '"+p',
    opts,
    {
        desc = "Paste system clipboard"
    }

)

vim.keymap.set(
    "n",
    "<leader>c",
    ":nohlsearch<CR>",
    {
        desc = "Clear search highlights"
    }
)

-- Center screen when jumping between search results
vim.keymap.set(
    "n",
    "n",
    "nzzzv",
    {
        desc = "Next search result (centered)"
    }
)

vim.keymap.set(
    "n",
    "N",
    "Nzzzv",
    {
        desc = "Previous search result (centered)"
    }
)

vim.keymap.set(
    "n",
    "<C-d>",
    "<C-d>zz",
    {
        desc = "Half page down (centered)"
    }
)

vim.keymap.set(
    "n",
    "<C-u>",
    "<C-u>zz",
    {
        desc = "Half page up (centered)"
    }
)

-- Delete without yanking
vim.keymap.set(
    {
        "n",
        "v"
    },
    "<leader>d",
    '"_d',
    opts,
    {
        desc = "Delete without yanking"
    }
)

-- Buffer navigation
vim.keymap.set(
    "n",
    "<leader>bn",
    ":bnext<CR>",
    {
        desc = "Next buffer"
    }
)

vim.keymap.set(
    "n",
    "<leader>bp",
    ":bprevious<CR>",
    {
        desc = "Previous buffer"
    }
)

-- Better window navigation
vim.keymap.set(
    "n",
    "<C-h>",
    "<C-w>h",
    {
        desc = "Move to left window"
    }
)

vim.keymap.set(
    "n",
    "<C-j>",
    "<C-w>j",
    {
        desc = "Move to bottom window"
    }
)

vim.keymap.set(
    "n",
    "<C-k>",
    "<C-w>k",
    {
        desc = "Move to top window"
    }
)

vim.keymap.set(
    "n",
    "<C-l>",
    "<C-w>l",
    {
        desc = "Move to right window"
    }
)

-- Splitting & Resizing
vim.keymap.set(
    "n",
    "<leader>sv",
    ":vsplit<CR>",
    {
        desc = "Split window vertically"
    }
)

vim.keymap.set(
    "n",
    "<leader>sh",
    ":split<CR>",
    {
        desc = "Split window horizontally"
    }
)

vim.keymap.set(
    "n",
    "<C-Up>",
    ":resize +2<CR>",
    {
        desc = "Increase window height"
    }
)

vim.keymap.set(
    "n",
    "<C-Down>",
    ":resize -2<CR>",
    {
        desc = "Decrease window height"
    }
)

vim.keymap.set(
    "n",
    "<C-Left>",
    ":vertical resize -2<CR>",
    {
        desc = "Decrease window width"
    }
)

vim.keymap.set(
    "n",
    "<C-Right>",
    ":vertical resize +2<CR>",
    {
        desc = "Increase window width"
    }
)

-- Move lines up/down
vim.keymap.set(
    "n",
    "<A-j>",
    ":m .+1<CR>==",
    {
        desc = "Move line down"
    }
)

vim.keymap.set(
    "n",
    "<A-k>",
    ":m .-2<CR>==",
    {
        desc = "Move line up"
    }
)

vim.keymap.set(
    "v",
    "<A-j>",
    ":m '>+1<CR>gv=gv",
    {
        desc = "Move selection down"
    }
)

vim.keymap.set(
    "v",
    "<A-k>",
    ":m '<-2<CR>gv=gv",
    {
        desc = "Move selection up"
    }
)

-- Better indenting in visual mode
vim.keymap.set(
    "v",
    "<",
    "<gv",
    {
        desc = "Indent left and reselect"
    }
)

vim.keymap.set(
    "v",
    ">",
    ">gv",
    {
        desc = "Indent right and reselect"
    }
)

-- Quick file navigation
vim.keymap.set(
    "n",
    "<leader>e",
    ":Explore<CR>",
    {
        desc = "Open file explorer"
    }
)

vim.keymap.set(
    "n",
    "<leader>ff",
    ":find ",
    {
        desc = "Find file"
    }
)

-- Better J behavior
vim.keymap.set(
    "n",
    "J",
    "mzJ`z",
    opts,
    {
        desc = "Join lines and keep cursor position"
    }
)
