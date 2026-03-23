-- C#
vim.lsp.config("csharp", {
    on_attach = On_attach,
    filetypes = { "cs" },
    capabilities = { Capabilities },
    cmd = { "csharp-ls" },
})
