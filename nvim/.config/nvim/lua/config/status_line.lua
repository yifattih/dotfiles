-- Author: Yifattih
-- A good portion of this configuration comes from:
-- https://github.com/radleylewis/nvim-lite/blob/youtube_demo/init.lua
-- ===========================================================================
-- STATUSLINE CONFIGURATION
-- ===========================================================================

-- Git branch function with icon
local function git_branch()
    local branch = vim.fn.system("git branch --show-current 2>/dev/null | tr -d '\n'")
    if branch ~= "" then
        return " " .. branch
    end
    return ""
end

-- File type with icons (Nerd Font)
local function file_type()
    local ft = vim.bo.filetype
    local icons = {
        lua = " LUA",
        python = " PY",
        javascript = " JS",
        html = " HTML",
        css = " CSS",
        json = " JSON",
        markdown = " MD",
        vim = " VIM",
        sh = " SH",
        text = "󰈙 TEXT",
    }

    return icons[ft] or (ft ~= "" and ft:upper() or "NoFT")
end

-- LSP status
local function lsp_status()
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    if #clients > 0 then
        return " LSP"
    end
    return ""
end

-- File size
local function file_size()
    local size = vim.fn.getfsize(vim.fn.expand('%'))
    if size < 0 then return "" end
    if size < 1024 then
        return size .. "B"
    elseif size < 1024 * 1024 then
        return string.format("%.1fK", size / 1024)
    else
        return string.format("%.1fM", size / 1024 / 1024)
    end
end

-- Mode with icons
local function mode_icon()
    local mode = vim.fn.mode()
    local cmd_type = vim.fn.getcmdtype()

    -- Only during command-line entry (when mode == "c")
    if mode == "c" then
        if cmd_type == ":" then
            return " CMD"
        elseif cmd_type == "/" then
            return "󱁴 SEARCH"
        elseif cmd_type == "?" then
            return "󱁴 SEARCH ↑"
        end
        return " CMD" -- fallback
    end

    -- Normal editor modes
    local icons = {
        n = "󰛡 NORMAL",
        i = "󰏪 INSERT",
        v = "󰈈 VISUAL",
        V = "󰈈 V-LINE",
        ["\22"] = "󰈈 V-BLOCK", -- Ctrl-V
        R = " REPLACE",
        t = " TERM",
    }

    return icons[mode] or (" " .. mode:upper())
end

_G.mode_icon = mode_icon
_G.git_branch = git_branch
_G.file_type = file_type
_G.file_size = file_size
_G.lsp_status = lsp_status

-- Unokai-inspired highlights
vim.api.nvim_set_hl(
    0,
    "StatusLine",
    {
        fg = "#dcd7ba",
        bg = "none"
    }
)

vim.api.nvim_set_hl(
    0,
    "StatusLineBold",
    {
        fg = "#dcd7ba",
        bold = true
    }
)

vim.api.nvim_set_hl(
    0,
    "StatusLineInactive",
    {
        fg = "#7e8294",
        bg = "none"
    }
)

-- Function to set dynamic statusline
local function setup_dynamic_statusline()
    vim.api.nvim_create_autocmd(
        {
            "WinEnter",
            "BufEnter"
        },
        {
            callback = function()
                vim.opt_local.statusline = table.concat {
                    "  ",
                    "%#StatusLineBold#",
                    "%{v:lua.mode_icon()}",
                    "%#StatusLine#",
                    " │ %f %h%m%r ",
                    "%{v:lua.git_branch()}",
                    " │ ",
                    "%{v:lua.file_type()}",
                    " │ ",
                    "%{v:lua.file_size()}",
                    " │ ",
                    "%{v:lua.lsp_status()}",
                    " %=",
                    " %l:%c  %p%% ",
                }
            end
        }
    )

    vim.api.nvim_create_autocmd(
        {
            "WinLeave",
            "BufLeave"
        },
        {
            callback = function()
                vim.opt_local.statusline = "%#StatusLineInactive#  %f %m %r %= %l:%c  %p%% "
            end
        }
    )
end

setup_dynamic_statusline()
