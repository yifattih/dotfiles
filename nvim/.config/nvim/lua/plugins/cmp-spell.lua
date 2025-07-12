-- Author: Yifattih
-- ===========================================================================
-- CMP SPELL
-- ===========================================================================

return {
    "f3fora/cmp-spell",
    enabled = true,
    ft = {
        "markdown",
        "text",
        "gitcommit"
    },
    config = function()
        vim.opt.spell = true
        vim.opt.spelllang = { "en" }
    end,
}
