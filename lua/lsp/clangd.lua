-- clangd
vim.lsp.config('clangd',{
    cmd = { 'clangd', '--background-index', '--clang-tidy' },
    filetypes = { 'c', 'cpp' },
    capabilities = { capabilities },
    on_attach = on_attach
})

