local function format_buffer()
    require("conform").format({
        async = true,
        lsp_format = "fallback"
    })
end

return {{
    "stevearc/conform.nvim",
    lazy = false,
    keys = {{
        "<leader>f",
        format_buffer,
        desc = "Format buffer"
    }},
    opts = {
        formatters_by_ft = {
            lua = {"stylua"},
            nix = {
                "nixpkgs_fmt",
                stop_after_first = true
            },
            python = {"ruff_format", "ruff_organize_imports"},
            tex = {"tex-fmt"},
            plaintex = {"tex-fmt"}
        },
        formatters = {
            nix = {
                command = "nix",
                args = {"fmt", "$FILENAME"},
                stdin = false
            },
            nixpkgs_fmt = {
                command = "nixfmt",
                stdin = true
            },
            gleam = {
                cmd = "gleam",
                args = {"format", "--stdin"},
                stdin = true
            }
        }
    }
}, {
    "neovim/nvim-lspconfig",
    dependencies = {"saghen/blink.cmp"},
    opts = {
        servers = {
            lua_ls = {},
            pyright = {},
            rust_analyzer = {},
            gleam = {},
            -- use LanguageTool via ltex for spell checking
            -- TODO: https://dev.languagetool.org/finding-errors-using-n-gram-data.html
            ltex = {
                filetypes = {"bib", "gitcommit", "latex", "mail", "markdown", "norg", "org", "pandoc", "rst", "text"},

                settings = {
                    -- https://valentjn.github.io/ltex/settings.html
                    ltex = {
                        language = "en-US",
                        languageToolOrg = {
                            username = "joe.c.starr@gmail.com",
                            apiKey = "pit-vJpphdBZ3rnf"
                        },
                        languageToolHttpServerUri = "https:\\api.languagetoolplus.com"
                    }
                    -- https://community.languagetool.org/rule/list?lang=en
                    -- disabledRules = {
                    --     ["en-GB"] = {"TOO_LONG_SENTENCE", "OXFORD_SPELLING_Z_NOT_S", "DASH_RULE"},
                    --     fr = {"APOS_TYP", "FRENCH_WHITESPACE", "FR_SPELLING_RULE", "COMMA_PARENTHESIS_WHITESPACE"}
                    -- }
                }
            }
        }
    }
}}
