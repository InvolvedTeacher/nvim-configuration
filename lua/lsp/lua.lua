-- lua
vim.lsp.config('lua_ls',{
    on_attach = on_attach ,
    filetypes = { 'lua' },
    capabilities = { capabilities },
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

