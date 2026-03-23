-- lua
vim.lsp.config('lua_ls', {
    on_attach = On_attach,
    filetypes = { 'lua' },
    capabilities = { Capabilities },
    cmd = { 'lua-language-server' },
    root_markers = {
        ".luarc.json",
        ".luarc.jsonc",
        ".luacheckrc",
        ".stylua.toml",
        ".git",
    },
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            }
        }
    }
})
