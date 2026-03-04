-- # General Settings
-- --

-- Set leader to <space>
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- ## Appearance
-- -- --

-- Tab settings (tabs to 4 spaces)
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Vertical rulers
vim.opt.colorcolumn = {"80", "100"}

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = 'yes'

-- Autocomplete
vim.cmd('set completeopt+=noselect,menuone,popup')

-- Other
vim.opt.termguicolors = true
vim.o.cursorline = true
vim.opt.wrap = true
vim.opt.winborder = 'rounded'
vim.opt.scrolloff = 10

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- \\ Appearance 

-- Tabs navigation
vim.keymap.set({'n','i'}, '<C-h>', ':tabprevious<CR>')
vim.keymap.set({'n','i'}, '<C-l>', ':tabnext<CR>')

-- \\ Navigation

-- Reload this file (for quick iterations trying confs)
vim.keymap.set('n', '<leader>+', ':update<CR> :source<CR>')

-- Exit terminal with <esc>
vim.keymap.set('t', '<esc>', '<c-\\><c-n>', { desc = 'esc in terinal mode.' })

-- Other
vim.opt.swapfile = false
vim.opt.clipboard = 'unnamedplus'
vim.opt.mouse = "a"
vim.g.vim_ui_open_cmd = 'gio open'

-- \ General settings

-- # Plugin installation and setup
-- --
vim.pack.add({
    { src = 'https://github.com/catppuccin/nvim.git' },
})

-- Catpuccin
catppuccin = require('catppuccin')
catppuccin.setup()
vim.cmd.colorscheme('catppuccin')
vim.cmd.highlight({'Normal', 'guibg=none'})
vim.cmd.highlight({"NonText", "guibg=none"})
vim.cmd.highlight({"Normal", "ctermbg=none"})
vim.cmd.highlight({"NonText", "ctermbg=none"})

-- \ Plugin installation and setup 

--[[ TODO look these ones up and set up to my preferences
vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, { desc = 'vim.lsp.buf.definition' })
vim.keymap.set('n', '<leader>fo', vim.lsp.buf.format, { desc = 'vim.lsp.buf.format' })
]]

