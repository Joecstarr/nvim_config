return {
    "saghen/blink.cmp",
    -- optional: provides snippets for the snippet source
    dependencies = {
        "moyiz/blink-emoji.nvim",
        -- "erooke/blink-cmp-latex",
        dependencies = { "L3MON4D3/LuaSnip", version = "v2.*" },
    },

    -- use a release tag to download pre-built binaries
    version = "1.*",
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        keymap = {
            preset = "default",
            ["<Tab>"] = {
                function(cmp)
                    if cmp.snippet_active() then
                        return cmp.accept()
                    else
                        return cmp.select_and_accept()
                    end
                end,
                "snippet_forward",
                "fallback",
            },
        },

        appearance = {
            nerd_font_variant = "mono",
        },

        -- (Default) Only show the documentation popup when manually triggered
        completion = { documentation = { auto_show = true } },

        snippets = { preset = "luasnip" },

        -- Default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, due to `opts_extend`
        sources = {
            default = { "lazydev", "lsp", "path", "snippets", "buffer", "emoji" },

            providers = {
                emoji = {
                    module = "blink-emoji",
                    name = "Emoji",
                },
                lazydev = {
                    name = "LazyDev",
                    module = "lazydev.integrations.blink",
                    score_offset = 100,
                },
                -- latex = {
                --     name = "Latex",
                --     module = "blink-cmp-latex",
                --     opts = {
                --         insert_command = function(ctx)
                --             local ft = vim.api.nvim_get_option_value("filetype", {
                --                 scope = "local",
                --                 buf = ctx.bufnr,
                --             })
                --             if ft == "tex" then
                --                 return true
                --             end
                --             return false
                --         end,
                --     },
                -- },
            },
        },

        fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
}
