return {{
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
        local wk = require("which-key")

        wk.setup({
            icons = {
                separator = "∷"
            },
            layout = {
                align = "center"
            }
        })

        wk.add({{
            "<leader>d",
            group = "diagnostics"
        }, {
            "<leader>dq",
            vim.diagnostic.setqflist,
            desc = "send to quickfix"
        }, {
            "<leader>dn",
            function()
                vim.diagnostic.jump({
                    count = 1,
                    float = true
                })
            end,
            desc = "next diagnostic"
        }, {
            "<leader>dp",
            function()
                vim.diagnostic.jump({
                    count = -1,
                    float = true
                })
            end,
            desc = "prev diagnostic"
        }, {
            "<leader>g",
            group = "git"
        }, {
            "<leader>l",
            group = "lsp"
        }, {
            "<leader>t",
            group = "telescope"
        }})

        require("options.keybinds")
    end
}, {
    "LazyVim/LazyVim",
    opts = {
        colorscheme = "dracula_pro"
    }
}}
