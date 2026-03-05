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

        -- Window splits
vim.opt.splitright = true
vim.opt.splitbelow = true

        -- Whitespace characters display
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

        -- Autocomplete
vim.cmd("set completeopt+=noinsert,menuone,popup")

        -- Other appearance settings
vim.opt.termguicolors = true
vim.opt.cursorline = true
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
        -- Enable undo/redo even after closing and reopening file
vim.opt.undofile = true
        -- Case insensitive search unless \C or one or more capital letters used
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Plugin installation and setup

vim.pack.add({
    { src = "https://github.com/catppuccin/nvim.git" },
    { src = "https://github.com/MunifTanjim/nui.nvim.git" },    -- for neo-tree
    { src = "https://github.com/nvim-lua/plenary.nvim.git" },   -- for neo-tree, telescope
    { src = "https://github.com/nvim-tree/nvim-web-devicons" }, -- for neo-tree, which-key
    { src = "https://github.com/nvim-neo-tree/neo-tree.nvim", version = vim.version.range('3') },
    { src = 'https://github.com/nvim-telescope/telescope.nvim.git' },
    { src = 'https://github.com/sindrets/diffview.nvim.git' },  -- for neogit
    { src = 'https://github.com/NeogitOrg/neogit.git' },
    { src = "https://github.com/nvim-mini/mini.icons.git" },    -- for which-key
    { src = "https://github.com/folke/which-key.nvim.git" },
    { src = "https://github.com/hrsh7th/nvim-cmp.git" },        -- for blink.cmp
    { src = "https://github.com/hrsh7th/cmp-nvim-lsp.git" },    -- for blink.cmp
    { src = "https://github.com/saghen/blink.cmp.git" },
    { src = "https://github.com/stevearc/conform.nvim.git" },
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
        -- Keymaps
vim.keymap.set('n', "<leader>t", function()
    require("neo-tree.command").execute({ 
        action="focus", source="filesystem", position="float", toggle=true 
    })
    end , { desc = "Open filesystem in Neotree" })


    -- Telescope
builtin = require('telescope.builtin')

        -- Keymaps
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
vim.keymap.set({ 'n', 'v' }, '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set('n', '<leader>sc', builtin.commands, { desc = '[S]earch [C]ommands' })
vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

    -- Neogit
    -- TODO Check neogit docs to learn more.
git = require("neogit")

        -- Keymaps
vim.keymap.set('n', '<leader>gs', function() Git.open({kind='split'}) end, { desc = 'pick buffers' })
vim.keymap.set('n', '<leader>gd', "<cmd>DiffviewOpen<CR>", { desc = 'pick buffers' })

    -- Blink
blink = require("blink.cmp")
blink.setup({
    keymap = { preset = 'default' },
    appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono'
    },
    completion = {
        documentation = { auto_show = true }
    },
    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    fuzzy = {
        implementation = "lua"
    },
})

-- LSP setup
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())


local on_attach = function(client, bufnr)
    vim.lsp.completion.enable(true, client.id, bufnr, {
        autotrigger = true,
        convert = function(item)
            return { abbr = item.label:gsub('%b()', '') }
        end,
    })
    vim.keymap.set('i', '<C-space>', vim.lsp.completion.get, { desc = 'trigger autocompletion' })
end

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

    -- clangd
vim.lsp.config('clangd',{
    cmd = { 'clangd', '--background-index', '--clang-tidy' },
    filetypes = { 'c', 'cpp' },
    capabilities = { capabilities },
    on_attach = on_attach
})

    -- Enable LSPs
vim.lsp.enable({ "lua_ls", "clangd", "gdscript" })

-- Autoformat

    -- Conform
conform = require("conform")
conform.setup({
    formatters_by_ft = {
        lua = { "stylua" },
        cpp = { "clangd" },
    },
    format_on_save = {
        timeout_ms = 500,
        lsp_format = "prefer",
    },
})

-- Additional keymaps

    -- Temporary, for good practices: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')


--[[ TODO look these ones up and set up to my preferences
vim.keymap.set('n', "<leader>gd", vim.lsp.buf.definition, { desc = "vim.lsp.buf.definition" })
vim.keymap.set('n', "<leader>fo", vim.lsp.buf.format, { desc = "vim.lsp.buf.format" })
]]

