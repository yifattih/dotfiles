-- Author: Yifattih
-- Some parts of this configuration comes from:
-- https://github.com/radleylewis/nvim-lite/blob/youtube_demo/init.lua
-- ===========================================================================
-- GENERAL KEYMAPS
-- ===========================================================================

local terminal = require("utils.floating_terminal")
local termina_runner = require("utils.floating_terminal_runner")
local tabs = require("utils.tabs")

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

vim.keymap.set(
    "n",
    "<leader>mww",
    ":set wrap<CR>",
    {
        desc = "Enable line wrap"
    }
)

vim.keymap.set(
    "n",
    "<leader>mw!",
    ":set wrap!<CR>",
    {
        desc = "Disable line wrap"
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

-- ===========================================================================
-- FLOATING TERMINAL
-- ===========================================================================

-- Run file in floating terminal
vim.keymap.set(
    "n",
    "<leader>r",
    termina_runner.run_current_file,
    {
        desc = "Run current file in floating terminal"
    }
)

vim.keymap.set(
    "n",
    "<leader>t",
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

-- ===========================================================================
-- LSP KEYMAPS
-- ===========================================================================

vim.api.nvim_create_autocmd(
    "LspAttach",
    {
        callback = function(args)
            -- Go to definitions, declarations, etc.
            vim.keymap.set(
                "n",
                "gd",
                vim.lsp.buf.definition,
                {
                    buffer = args.buf,
                    noremap = true,
                    silent = true,
                    desc = "Go to definition"
                }
            )

            vim.keymap.set(
                "n",
                "gD",
                vim.lsp.buf.declaration,
                opts,
                {
                    desc = "Go to declaration"
                }
            )

            vim.keymap.set(
                "n",
                "gi",
                vim.lsp.buf.implementation,
                opts,
                {
                    desc = "Go to implementation"
                }
            )

            vim.keymap.set(
                "n",
                "gr",
                vim.lsp.buf.references,
                opts,
                {
                    desc = "Go to references"
                }
            )

            vim.keymap.set(
                "n",
                "K",
                vim.lsp.buf.hover,
                opts,
                {
                    desc = "Hover docs"
                }
            )

            vim.keymap.set(
                "n",
                "<C-k>",
                vim.lsp.buf.signature_help,
                opts,
                {
                    desc = "Signature help"
                }
            )

            -- LSP actions
            vim.keymap.set(
                "n",
                "<leader>rn",
                vim.lsp.buf.rename,
                opts,
                {
                    desc = "Rename symbol"
                }
            )

            vim.keymap.set(
                "n",
                "<leader>ca",
                vim.lsp.buf.code_action,
                opts,
                {
                    desc = "Code action"
                }
            )

            -- Diagnostics
            vim.keymap.set(
                "n",
                "<leader>da",
                vim.diagnostic.open_float,
                opts,
                {
                    desc = "Show diagnostic float"
                }
            )

            vim.keymap.set(
                "n",
                "<leader>dan",
                vim.diagnostic.goto_next,
                opts,
                {
                    desc = "Next diagnostic"
                }
            )

            vim.keymap.set(
                "n",
                "<leader>dap",
                vim.diagnostic.goto_prev,
                opts,
                {
                    desc = "Previous diagnostic"
                }
            )

            vim.keymap.set(
                "n",
                "<leader>dal",
                vim.diagnostic.setloclist,
                opts,
                {
                    desc = "Diagnostic list"
                }
            )
        end
    }
)

-- Manual formatting using :Format
vim.api.nvim_create_user_command(
    "Format",
    function()
        vim.lsp.buf.format()
    end,
    {}
)

-- Manual formatting keymap
vim.keymap.set(
    "n",
    "<leader>fm",
    function()
        vim.lsp.buf.format()
    end,
    opts,
    {
        desc = "Format file"
    }
)

-- ===========================================================================
-- TABS
-- ===========================================================================

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

-- Tab moving
vim.keymap.set(
    'n',
    '<leader>tm',
    ':tabmove<CR>',
    opts,
    {
        desc = 'Move tab'
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

vim.keymap.set(
    'n',
    '<leader>tr',
    tabs.close_tabs_right,
    {
        desc = 'Close tabs to the right'
    }
)

vim.keymap.set(
    'n',
    '<leader>tL',
    tabs.close_tabs_left,
    {
        desc = 'Close tabs to the left'
    }
)

vim.keymap.set(
    'n',
    '<leader>bd',
    tabs.smart_close_buffer,
    {
        desc = 'Smart close buffer/tab'
    }
)
