-- Catpuccin
catppuccin = require("catppuccin")

catppuccin.setup()

vim.cmd.colorscheme("catppuccin")
vim.cmd.highlight({"Normal", "guibg=none"})
vim.cmd.highlight({"NonText", "guibg=none"})
vim.cmd.highlight({"Normal", "ctermbg=none"})
vim.cmd.highlight({"NonText", "ctermbg=none"})

