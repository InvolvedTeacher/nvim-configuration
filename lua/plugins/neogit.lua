-- Neogit
-- TODO Check neogit docs to learn more.
local git = require("neogit")

-- Keymaps
vim.keymap.set('n', '<leader>gs', function() git.open({ kind = 'auto' }) end, { desc = "Open Neogit Status" })
vim.keymap.set('n', '<leader>gd', "<cmd>DiffviewOpen<CR>", { desc = "Open Neogit Diff" })
