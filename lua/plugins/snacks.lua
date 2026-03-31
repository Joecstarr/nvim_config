return {
    {
        "folke/snacks.nvim",
        lazy = false,
        keys = {
            {
                "<leader>.",
                function()
                    Snacks.scratch()
                end,
                desc = "Toggle Scratch Buffer",
            },
            {
                "<leader>S",
                function()
                    Snacks.scratch.select()
                end,
                desc = "Select Scratch Buffer",
            },
            {
                "<leader>,",
                function()
                    Snacks.picker.buffers()
                end,
                desc = "Buffers",
            },
            {
                "<leader>uC",
                function()
                    Snacks.picker.colorschemes()
                end,
                desc = "Colorschemes",
            },
            {
                "<leader>fb",
                function()
                    Snacks.picker.buffers()
                end,
                desc = "Buffers",
            },
            {
                "<leader>fB",
                function()
                    Snacks.picker.buffers({ hidden = true, nofile = true })
                end,
                desc = "Buffers (all)",
            },
        },
        opts = {
            picker = {
                -- your picker configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            },
            scratch = {
                -- your scratch configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            },
        },
    },
}
