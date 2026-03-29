return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        version = false, -- last release is way too old and doesn't work on Windows
        build = function()
            local TS = require("nvim-treesitter")
            if not TS.get_installed then
                return
            end
            TS.update(nil, { summary = true })
        end,
        lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
        cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
        opts_extend = { "ensure_installed" },
        ---@class lazyvim.TSConfig: TSConfig
        opts = {
            -- LazyVim config for treesitter
            ensure_installed = {
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
            },
            highlight = {
                enable = true,
                disable = { "markdown" },

                -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                additional_vim_regex_highlighting = false,
            },
        },
        ---@param opts lazyvim.TSConfig
        config = function(_, opts)
            local TS = require("nvim-treesitter")

            -- some quick sanity checks

            -- setup treesitter
            TS.setup(opts)

            -- install missing parsers
            local install = vim.tbl_filter(function(lang) end, opts.ensure_installed or {})
            if #install > 0 then
                TS.install(install, { summary = true }):await(function() end)
            end

            -- treesitter highlighting
            vim.api.nvim_create_autocmd("FileType", {
                callback = function(ev) end,
            })

            vim.treesitter.language.register("markdown", "mdx") -- the someft filetype will use the python parser and queries.
        end,
    },
}
