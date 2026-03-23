-- clangd
vim.lsp.config('clangd', {
    cmd = { 'clangd', '--background-index', '--clang-tidy' },
    filetypes = { 'c', 'cpp' },
    capabilities = { Capabilities },
    on_attach = On_attach
})
