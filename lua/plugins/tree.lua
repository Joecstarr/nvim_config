return {
    { "nvim-neo-tree/neo-tree.nvim", enabled = false },
    {
        "nvim-mini/mini.files",
        lazy = false,
        version = "*",
        config = function()
            require("mini.files").setup()
        end,
        keys = {
            {
                "<leader>e",
                function()
                    require("mini.files").open()
                end,
                desc = "filetree",
                { noremap = true },
            },
        },
    },
}
