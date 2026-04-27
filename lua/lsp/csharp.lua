-- C#
vim.lsp.config("csharp", {
    on_attach = On_attach,
    filetypes = { "cs" },
    capabilities = { Capabilities },
    cmd = (function()
        -- try to find a .sln or .csproj from cwd or buffer; fallback to plain command
        local cwd = vim.fn.getcwd()
        local sln = vim.fn.globpath(cwd, "*.sln", false, true)[1]
        if not sln or sln == "" then
            sln = vim.fn.globpath(cwd, "*.csproj", false, true)[1]
        end
        if sln and sln ~= "" then
            return { "csharp-ls", "--solution", sln }
        end
        -- If root_dir is used, LSP client will set workspaceFolder; but pass nothing if not found
        return { "csharp-ls" }
    end)(),
})
