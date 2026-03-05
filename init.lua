-- Core settings
require "core"

-- Plugins setup
require "plugins"

-- LSP setup
require "lsp"

-- Autoformat
require "autoformat"

-- Additional keymaps

--[[ TODO look these ones up and set up to my preferences
vim.keymap.set('n', "<leader>gd", vim.lsp.buf.definition, { desc = "vim.lsp.buf.definition" })
vim.keymap.set('n', "<leader>fo", vim.lsp.buf.format, { desc = "vim.lsp.buf.format" })
]]

