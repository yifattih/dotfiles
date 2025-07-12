-- Author: Yifattih
-- A good portion of this configuration comes from:
-- https://github.com/radleylewis/nvim-lite/blob/youtube_demo/init.lua
-- ===========================================================================
-- LANGUAGE SERVER PROTOCOL
-- ===========================================================================

return {
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        dependencies = {
            {
                "williamboman/mason.nvim",
                config = function()
                    require("mason").setup()

                    local mr = require("mason-registry")
                    local tool = "markdownlint-cli2"
                    if not mr.is_installed(tool) then
                        mr.get_package(tool):install()
                    end
                end,
            },
            {
                "williamboman/mason-lspconfig.nvim",
                version = ">=1.1.0",
                config = function()
                    local mason_lspconfig = require("mason-lspconfig")
                    local lspconfig = require("lspconfig")

                    mason_lspconfig.setup({
                        ensure_installed = {
                            "bashls",   -- Shell
                            "lua_ls",   -- Lua
                            "pyright",  -- Python
                            "dockerls", -- Dockerfile
                            "yamlls",   -- YAML
                            "jsonls",   -- JSON
                            "marksman", -- Markdown
                        },
                        automatic_installation = true,
                    })

                    -- Explicit server configs
                    local servers = {
                        bashls = {},
                        pyright = {},
                        dockerls = {},
                        yamlls = {},
                        jsonls = {},
                        marksman = {},
                        lua_ls = {
                            settings = {
                                Lua = {
                                    diagnostics = {
                                        globals = { "vim" },
                                    },
                                    workspace = {
                                        checkThirdParty = false,
                                    },
                                },
                            },
                        },
                    }

                    for server, config in pairs(servers) do
                        lspconfig[server].setup(config)
                    end
                end,
            },
        },
    },
}
