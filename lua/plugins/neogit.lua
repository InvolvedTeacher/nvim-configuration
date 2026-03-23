-- Neogit
-- TODO Check neogit docs to learn more.
git = require("neogit")

-- Keymaps
vim.keymap.set('n', '<leader>gs', function() git.open({ kind = 'split' }) end, { desc = 'pick buffers' })
vim.keymap.set('n', '<leader>gd', "<cmd>DiffviewOpen<CR>", { desc = 'pick buffers' })
