-- Author: Yifattih
-- ===========================================================================
-- LANGUAGE SERVER PROTOCOL CONFIGURATION
-- ===========================================================================

vim.diagnostic.config(
    {
        virtual_text = {
            prefix = ">>",
            spacing = 4,
        },
        signs = true,
        underline = true,
        update_in_insert = false, -- only update when leaving insert
        severity_sort = true,
    }
)

-- Custom sign icons for gutter
local signs = {
    Error = "✘",
    Warn = "▲",
    Hint = "⚑",
    Info = ""
}

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(
        hl,
        {
            text = icon,
            texthl = hl,
            numhl = ""
        }
    )
end

vim.api.nvim_create_autocmd(
    "LspAttach",
    {
        callback = function(ev)
            vim.b[ev.buf].lsp_attached = true
        end
    }
)

-- Format on save
vim.api.nvim_create_autocmd(
    "LspAttach",
    {
        callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            local bufnr = args.buf

            if client.supports_method("textDocument/formatting") then
                vim.api.nvim_create_autocmd(
                    "BufWritePre",
                    {
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format({ bufnr = bufnr })
                        end,
                    }
                )
            end
        end,
    }
)
