-- Author: Yifattih
-- A good portion of this configuration comes from:
-- https://github.com/radleylewis/nvim-lite/blob/youtube_demo/init.lua
-- ===========================================================================
-- GENERAL AUTOCMDS
-- ===========================================================================

-- Basic autocommands
local augroup = vim.api.nvim_create_augroup(
    "UserConfig",
    {}
)

-- Highlight yanked text
vim.api.nvim_create_autocmd(
    "textyankpost",
    {
        group = augroup,
        callback = function()
            vim.highlight.on_yank()
        end,
    }
)

-- Return to last edit position when opening files
vim.api.nvim_create_autocmd(
    "BufReadPost",
    {
        group = augroup,
        callback = function()
            local mark = vim.api.nvim_buf_get_mark(0, '"')
            local lcount = vim.api.nvim_buf_line_count(0)
            if mark[1] > 0 and mark[1] <= lcount then
                pcall(vim.api.nvim_win_set_cursor, 0, mark)
            end
        end,
    }
)

-- Set filetype-specific settings
vim.api.nvim_create_autocmd(
    "FileType",
    {
        group = augroup,
        pattern = {
            "lua",
            "python"
        },
        callback = function()
            vim.opt_local.tabstop = 4
            vim.opt_local.shiftwidth = 4
        end,
    }
)

vim.api.nvim_create_autocmd(
    "FileType",
    {
        group = augroup,
        pattern = {
            "javascript",
            "typescript",
            "json",
            "html",
            "css"
        },
        callback = function()
            vim.opt_local.tabstop = 2
            vim.opt_local.shiftwidth = 2
        end,
    }
)

-- Auto-close terminal when process exits
vim.api.nvim_create_autocmd(
    "TermClose",
    {
        group = augroup,
        callback = function()
            if vim.v.event.status == 0 then
                vim.api.nvim_buf_delete(0, {})
            end
        end,
    }
)

-- Disable line numbers in terminal
vim.api.nvim_create_autocmd(
    "TermOpen",
    {
        group = augroup,
        callback = function()
            vim.opt_local.number = false
            vim.opt_local.relativenumber = false
            vim.opt_local.signcolumn = "no"
        end,
    }
)

-- Auto-resize splits when window is resized
vim.api.nvim_create_autocmd(
    "VimResized",
    {
        group = augroup,
        callback = function()
            vim.cmd("tabdo wincmd =")
        end,
    }
)

-- Create directories when saving files
vim.api.nvim_create_autocmd(
    "BufWritePre",
    {
        group = augroup,
        callback = function()
            local dir = vim.fn.expand('<afile>:p:h')
            if vim.fn.isdirectory(dir) == 0 then
                vim.fn.mkdir(dir, 'p')
            end
        end,
    }
)

-- Create undo directory if it doesn't exist
local undodir = vim.fn.expand("~/.vim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
    vim.fn.mkdir(undodir, "p")
end
