-- Neo-tree
neo_tree = require("neo-tree")

neo_tree.setup({
    filesystem = {
        filtered_items = {
            always_show = {
                ".clang-format"
            },
        },
    },
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

