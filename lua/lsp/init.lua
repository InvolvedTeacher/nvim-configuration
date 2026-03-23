-- LSP setup
Capabilities = vim.lsp.protocol.make_client_capabilities()
Capabilities = vim.tbl_deep_extend("force", Capabilities, require("cmp_nvim_lsp").default_capabilities())

-- on_attach function, to use for all LSPs
On_attach = function(client, bufnr)
    vim.lsp.completion.enable(true, client.id, bufnr, {
        autotrigger = true,
        convert = function(item)
            return { abbr = item.label:gsub('%b()', '') }
        end,
    })
    vim.keymap.set('i', '<C-space>', vim.lsp.completion.get, { desc = 'trigger autocompletion' })
end

require("lsp.lua")
require("lsp.clangd")
require("lsp.gdscript")
require("lsp.csharp")

-- Enable LSPs
vim.lsp.enable({ "lua_ls", "clangd", "gdscript", "csharp" })
