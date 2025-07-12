-- Author: Yifattih
-- ===========================================================================
-- WHICH KEY
-- ==========================================================================

return {
    "folke/which-key.nvim",
    lazy = false,
    event = "VeryLazy",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "echasnovski/mini.icons",
    },
    opts = {
        plugins = {
            marks = true,
            registers = true,
            spelling = {
                enabled = true,
                suggestions = 20,
            },
            presets = {
                operators = false,
                motions = false,
                text_objects = false,
                windows = true,
                nav = true,
                z = true,
                g = true,
            },
        },
        icons = {
            breadcrumb = "»", -- Symbol before command path
            separator = "➜", -- Between key and name
            group = "+", -- Group prefix
        },
    },
}
