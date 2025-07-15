-- Author: Yifattih
-- ===========================================================================
-- FLOATING TERMINAL RUNNER
-- ===========================================================================
--
local terminal = require("utils.floating_terminal")

local M = {}

function M.run_current_file()
    local filename = vim.fn.expand("%:p")
    local filetype = vim.bo.filetype

    local runners = {
        python = "python3",
        sh = "bash",
        terraform = "terraform fmt %s && terraform apply -auto-approve",
        lua = "lua",
        javascript = "node",
    }

    local runner = runners[filetype]
    if not runner then
        vim.notify("Unsupported filetype: " .. filetype, vim.log.levels.WARN)
        return
    end

    local escaped = vim.fn.shellescape(filename)
    local cmd = runner:find("%%s") and runner:format(escaped) or (runner .. " " .. escaped)

    terminal.send(cmd)
end

return M
