-- C#
local cwd = vim.fn.getcwd()
local sln = vim.fn.globpath(cwd, "*.sln", false, true)[1]
if not sln or sln == "" then
    sln = vim.fn.globpath(cwd, "*.csproj", false, true)[1]
end
-- if solution does not exist, use current directory
if not sln or sln == "" then
    sln = "."
end

vim.lsp.config("csharp", {
    on_attach = On_attach,
    filetypes = { "cs" },
    capabilities = { Capabilities },
    cmd = { "OmniSharp", "-lsp", "-s", sln, "--hostPID", tostring(vim.fn.getpid()) },
})
