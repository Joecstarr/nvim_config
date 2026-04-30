return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        commit = vim.fn.has("nvim-0.12") == 0 and "7caec274fd19c12b55902a5b795100d21531391f" or nil,
        version = false, -- last release is way too old and doesn't work on Windows
        cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
        lazy = false,
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.config").setup({
                auto_install = true,
                -- LazyVim config for treesitter
                indent = { enable = true },
                highlight = { enable = true, additional_vim_regex_highlighting = false },
                folds = { enable = true },
                ensure_installed = "maintained",
            })
        end,
    },
}
