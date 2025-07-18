-- Author: Yifattih
-- ===========================================================================
-- NONE LS
-- ===========================================================================

return {
    "nvimtools/none-ls.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    config = function()
        local null_ls = require("null-ls")
        null_ls.setup(
            {
                sources = {
                    null_ls.builtins.diagnostics.markdownlint.with(
                        {
                            command = vim.fn.stdpath("data") .. "/mason/bin/markdownlint-cli2",
                        }
                    ),
                },
            }
        )
    end,
}
