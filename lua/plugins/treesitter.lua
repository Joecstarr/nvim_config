return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        commit = vim.fn.has("nvim-0.12") == 0 and "7caec274fd19c12b55902a5b795100d21531391f" or nil,
        version = false, -- last release is way too old and doesn't work on Windows
        cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
        lazy = false,
        build = ":TSUpdate",
        opt = {
            auto_install = true,
            indent = { enable = true },
            highlight = { enable = true, additional_vim_regex_highlighting = false },
            folds = { enable = true },
        },
        config = function(_, opts)
            local ts = require("nvim-treesitter")
            local languages = {
                "bash",
                "cpp",
                "c",
                "diff",
                "html",
                "javascript",
                "jsdoc",
                "json",
                "janet_simple",
                "lua",
                "luadoc",
                "luap",
                "latex",
                "markdown",
                "markdown_inline",
                "printf",
                "python",
                "query",
                "regex",
                "toml",
                "tsx",
                "typescript",
                "vim",
                "vimdoc",
                "xml",
                "yaml",
                "toml",
                "astro",
            }

            ts.setup(opts)
            -- Use :TSInstall for manuall install languages
            ts.install(languages)
        end,
    },
}
