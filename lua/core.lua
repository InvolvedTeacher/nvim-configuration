-- Set leader to <space>
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Tab settings (tabs to 4 spaces)
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Vertical rulers
vim.opt.colorcolumn = {"80"}

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true

-- Whitespace characters display
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Other appearance settings
vim.opt.termguicolors = true
vim.opt.wrap = true
vim.opt.winborder = "rounded"
vim.opt.scrolloff = 10
vim.g.have_nerd_font = true
vim.opt.showmode = false
vim.opt.confirm = true

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- Enable undo/redo even after closing and reopening file
vim.opt.undofile = true

-- Case insensitive search unless \C or one or more capital letters used
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- MAN stuff
vim.g.man_default_sects = '2,3'

    -- Open MAN on cursor
vim.keymap.set('n', "mm", function()
    local cursor = vim.fn.expand('<cword>')
    vim.api.nvim_command(':tab Man ' .. cursor)
end, {desc='open man on cursor'})

-- Other general settings
vim.opt.swapfile = false
vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = 'a'
vim.g.vim_ui_open_cmd = "gio open"

-- Keymaps

    -- Reload this file (for quick iterations trying confs)
    -- Note: with this conf this does not work.
-- vim.keymap.set('n', "<leader>+", ":update<CR> :source<CR>")

    -- Tabs navigation
vim.keymap.set({'n','i'}, "<C-h>", ":tabprevious<CR>")
vim.keymap.set({'n','i'}, "<C-l>", ":tabnext<CR>")

    -- Exit terminal with <esc>
vim.keymap.set('t', "<esc>", "<c-\\><c-n>", { desc = "esc in terinal mode." })

    -- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

    -- Temporary, for good practices: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')
