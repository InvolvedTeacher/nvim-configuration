-- C#
vim.lsp.config("csharp",{
    on_attach = on_attach,
    filetypes = { "cs" },
    capabilities = { capabilities },
    cmd = { "csharp-ls" },
})

