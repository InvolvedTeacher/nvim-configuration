-- Autoformat

-- Conform
local conform = require("conform")
conform.setup({
    formatters_by_ft = {
        lua = { "stylua" }, -- TODO: Fix (not working)
        cpp = { "clangd" },
    },
    format_on_save = {
        timeout_ms = 500,
        lsp_format = "prefer",
    },
})
