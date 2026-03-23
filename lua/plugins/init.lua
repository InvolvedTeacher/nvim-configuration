-- Plugin installation and setup

vim.pack.add({
    { src = "https://github.com/catppuccin/nvim.git" },
    { src = "https://github.com/MunifTanjim/nui.nvim.git" },    -- for neo-tree
    { src = "https://github.com/nvim-lua/plenary.nvim.git" },   -- for neo-tree, telescope, harpoon
    { src = "https://github.com/nvim-tree/nvim-web-devicons" }, -- for neo-tree, which-key
    {
        src = "https://github.com/nvim-neo-tree/neo-tree.nvim",
        version = vim.version.range('3')
    },
    { src = 'https://github.com/nvim-telescope/telescope.nvim.git' }, -- standalone, for harpoon
    { src = 'https://github.com/sindrets/diffview.nvim.git' },        -- for neogit
    { src = 'https://github.com/NeogitOrg/neogit.git' },
    { src = "https://github.com/nvim-mini/mini.icons.git" },          -- for which-key
    { src = "https://github.com/folke/which-key.nvim.git" },
    { src = "https://github.com/hrsh7th/nvim-cmp.git" },              -- for blink.cmp
    { src = "https://github.com/hrsh7th/cmp-nvim-lsp.git" },          -- for blink.cmp
    { src = "https://github.com/saghen/blink.cmp.git" },
    { src = "https://github.com/stevearc/conform.nvim.git" },
    { src = "https://github.com/lewis6991/gitsigns.nvim.git" }, -- for feline
    { src = "https://github.com/famiu/feline.nvim.git" },
    { src = "https://github.com/pianocomposer321/project-templates.nvim.git" },
    --    { src = "https://github.com/ThePrimeagen/harpoon.git", branch = "harpoon2" },
})

require("plugins.catppuccin")
require("plugins.neo-tree")
require("plugins.telescope")
require("plugins.neogit")
require("plugins.blink")
require("gitsigns")
require("plugins.feline")
-- require("plugins.harpoon")

-- Conform is set up in the automap config because it needs lsp set up before it.
