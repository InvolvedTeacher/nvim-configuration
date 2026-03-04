-- General Settings

    -- Set leader to <space>
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

    -- Appearance

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
vim.opt.signcolumn = "yes"

        -- Autocomplete
vim.cmd("set completeopt+=noselect,menuone,popup")

        -- Other appearance settings
vim.opt.termguicolors = true
vim.o.cursorline = true
vim.opt.wrap = true
vim.opt.winborder = "rounded"
vim.opt.scrolloff = 10

            -- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

            -- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

    -- Navigation

        -- Tabs navigation
vim.keymap.set({'n','i'}, "<C-h>", ":tabprevious<CR>")
vim.keymap.set({'n','i'}, "<C-l>", ":tabnext<CR>")

        -- Exit terminal with <esc>
vim.keymap.set('t', "<esc>", "<c-\\><c-n>", { desc = "esc in terinal mode." })

    -- Reload this file (for quick iterations trying confs)
vim.keymap.set('n', "<leader>+", ":update<CR> :source<CR>")

    -- MAN
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

-- Plugin installation and setup

vim.pack.add({
    { src = "https://github.com/catppuccin/nvim.git" },
    { src = "https://github.com/MunifTanjim/nui.nvim.git" },    -- for neo-tree
    { src = "https://github.com/nvim-lua/plenary.nvim.git" },   -- for neo-tree
    { src = "https://github.com/nvim-tree/nvim-web-devicons" }, -- for neo-tree
    { src = "https://github.com/nvim-neo-tree/neo-tree.nvim", version = vim.version.range('3') },
})

    -- Catpuccin
catppuccin = require("catppuccin")
catppuccin.setup()
vim.cmd.colorscheme("catppuccin")
vim.cmd.highlight({"Normal", "guibg=none"})
vim.cmd.highlight({"NonText", "guibg=none"})
vim.cmd.highlight({"Normal", "ctermbg=none"})
vim.cmd.highlight({"NonText", "ctermbg=none"})

    -- Neo-tree
neo_tree = require("neo-tree")
neo_tree.setup({
    enable_git_status = true,
    enable_diagnostics = true,
    event_handlers = {
        {
            event = "file_opened",
            handler = function()
                require("neo-tree.command").execute({ action = "close" })
            end,
        },
    },
    default_component_configs = {
        git_status = {
            symbols = {
                -- Change type
                added = "+", -- or "✚"
                modified = "",
                deleted = "-", -- this can only be used in the git_status source
                renamed = "󰁕", -- this can only be used in the git_status source
                -- Status type
                untracked = "",
                ignored = "",
                unstaged = "󰄱",
                staged = "",
                conflict = "",
            },
        },
    }
})


-- Additional keymaps

    -- Open filesystem in Neo-tree
vim.keymap.set('n', "<leader>t", function()
    require("neo-tree.command").execute({ 
        action="focus", source="filesystem", position="float", toggle=true 
    })
    end , { desc = "Filesystem tree" })


--[[ TODO look these ones up and set up to my preferences
vim.keymap.set('n', "<leader>gd", vim.lsp.buf.definition, { desc = "vim.lsp.buf.definition" })
vim.keymap.set('n', "<leader>fo", vim.lsp.buf.format, { desc = "vim.lsp.buf.format" })
]]

