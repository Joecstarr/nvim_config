return {
    -- {
    --     "f-person/git-blame.nvim",
    --     keys = {
    --         { "<leader>gb", ":GitBlameToggle <CR>", desc = "blame" },
    --     },
    -- },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({
                signs = {
                    add = { text = "+" },
                    change = { text = "~" },
                    delete = { text = "_" },
                    topdelete = { text = "‾" },
                    changedelete = { text = "~" },
                },
                signs_staged = {
                    add = { text = "+" },
                    change = { text = "~" },
                    delete = { text = "_" },
                    topdelete = { text = "‾" },
                    changedelete = { text = "~" },
                },

                on_attach = function(bufnr)
                    local gitsigns = require("gitsigns")

                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation
                    map("n", "]c", function()
                        if vim.wo.diff then
                            vim.cmd.normal({ "]c", bang = true })
                        else
                            gitsigns.nav_hunk("next")
                        end
                    end, { desc = "Next Hunk" })

                    map("n", "[c", function()
                        if vim.wo.diff then
                            vim.cmd.normal({ "[c", bang = true })
                        else
                            gitsigns.nav_hunk("prev")
                        end
                    end, { desc = "Last Hunk" })

                    -- Actions
                    map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage Hunk" })
                    map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Reset Hunk" })

                    map("v", "<leader>hs", function()
                        gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
                    end, { desc = "Stage Hunk" })

                    map("v", "<leader>hr", function()
                        gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
                    end, { desc = "Reset Hunk" })

                    map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Stage Buffer" })
                    map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Reset Buffer" })
                    map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview Hunk" })
                    map("n", "<leader>hi", gitsigns.preview_hunk_inline, { desc = "Preview Hunk Inline" })

                    map("n", "<leader>hb", function()
                        gitsigns.blame_line({ full = true })
                    end, { desc = "Blame" })

                    map("n", "<leader>hd", gitsigns.diffthis, { desc = "Diff This" })

                    map("n", "<leader>hD", function()
                        gitsigns.diffthis("~")
                    end, { desc = "Diff this ~" })

                    -- Toggles
                    map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Toggle line blame" })
                    map("n", "<leader>tw", gitsigns.toggle_word_diff, { desc = "Toggle word diff" })

                    -- Text object
                    map({ "o", "x" }, "ih", gitsigns.select_hunk, { desc = "Select Hunk" })
                end,
            })
        end,
    },
    -- { "akinsho/git-conflict.nvim", version = "*", config = true },
    {
        "akinsho/git-conflict.nvim",
        version = "*",
        init = function()
            vim.api.nvim_set_hl(0, "GitConflictCurrent", { fg = "#7aa2f7", bg = "NONE", bold = true })
            vim.api.nvim_set_hl(0, "GitConflictIncoming", { fg = "#9ece6a", bg = "NONE", bold = true })
            require("git-conflict").setup({
                default_mappings = true,
                default_commands = true,
                disable_diagnostics = false,
                list_opener = "copen",
                highlights = {
                    incoming = "GitConflictIncoming",
                    current = "GitConflictCurrent",
                },
            })
        end,
        keys = {
            {
                "<leader>gx",
                "<cmd>GitConflictListQf<cr>",
                desc = "List Conflicts",
            },
            {
                "<leader>gr",
                "<cmd>GitConflictRefresh<cr>",
                desc = "Refresh Conflicts",
            },
        },
    },
}
