return {
    {
        "danymat/neogen",
        -- Uncomment next line if you want to follow only stable versions
        -- version = "*"
        config = function()
            require("neogen").setup({
                enabled = true, --if you want to disable Neogen
                input_after_comment = false, -- (default: true) automatic jump (with insert mode) on inserted annotation
                -- jump_map = "<C-e>"       -- (DROPPED SUPPORT, see [here](#cycle-between-annotations) !) The keymap in order to jump in the annotation fields (in insert mode)
                vim.keymap.set("n", "<leader>gD", ":lua require('neogen').generate()<CR>", { noremap = true }),
                languages = {
                    c = {
                        template = {
                            annotation_convention = "my_doxygen",
                            my_doxygen = {
                                { nil, "/**", { no_results = true, type = { "func", "file", "class" } } },
                                { nil, " * \\file", { no_results = true, type = { "file" } } },
                                { nil, " * \\brief $1", { no_results = true, type = { "func", "file", "class" } } },
                                { nil, " */", { no_results = true, type = { "func", "file", "class" } } },
                                { nil, "", { no_results = true, type = { "file" } } },

                                { nil, "/**", { type = { "func", "class", "type" } } },
                                { "ClassName", " * \\class %s", { type = { "class" } } },
                                { "type", " * \\typedef %s", { type = { "type" } } },
                                { nil, " * \\brief $1", { type = { "func", "class", "type" } } },
                                { nil, " *", { type = { "func", "class", "type" } } },
                                { "tparam", " * \\tparam %s $1" },
                                { "parameters", " * \\param %s $1" },
                                { "return_statement", " * \\return $1" },
                                { nil, " */", { type = { "func", "class", "type" } } },
                            },
                        },
                    },
                },
            })
        end,
    },
}
