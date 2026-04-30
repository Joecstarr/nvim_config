return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = { "nvim-mini/mini.nvim" }, -- if you use the mini.nvim suite
        opts = {
            latex = {
                enabled = false,
                render_modes = false,
                converter = { "utftex", "latex2text" },
                highlight = "RenderMarkdownMath",
                position = "center",
                top_pad = 0,
                bottom_pad = 0,
            },
            callout = {
-- stylua: ignore start 
        -- Callouts are a special instance of a 'block_quote' that start with a 'shortcut_link'.
        -- The key is for healthcheck and to allow users to change its values, value type below.
        -- | raw        | matched against the raw text of a 'shortcut_link', case insensitive |
        -- | rendered   | replaces the 'raw' value when rendering                             |
        -- | highlight  | highlight for the 'rendered' text and quote markers                 |
        -- | quote_icon | optional override for quote.icon value for individual callout       |
        -- | category   | optional metadata useful for filtering                              |

        note      = { raw = '[!NOTE]',      rendered = '󰋽 Note',      highlight = 'RenderMarkdownInfo',    category = 'github'   },
        tip       = { raw = '[!TIP]',       rendered = '󰌶 Tip',       highlight = 'RenderMarkdownSuccess', category = 'github'   },
        important = { raw = '[!IMPORTANT]', rendered = '󰅾 Important', highlight = 'RenderMarkdownHint',    category = 'github'   },
        warning   = { raw = '[!WARNING]',   rendered = '󰀪 Warning',   highlight = 'RenderMarkdownWarn',    category = 'github'   },
        caution   = { raw = '[!CAUTION]',   rendered = '󰳦 Caution',   highlight = 'RenderMarkdownError',   category = 'github'   },
        -- Obsidian: https://help.obsidian.md/Editing+and+formatting/Callouts
        abstract  = { raw = '[!ABSTRACT]',  rendered = '󰨸 Abstract',  highlight = 'RenderMarkdownInfo',    category = 'obsidian' },
        summary   = { raw = '[!SUMMARY]',   rendered = '󰨸 Summary',   highlight = 'RenderMarkdownInfo',    category = 'obsidian' },
        tldr      = { raw = '[!TLDR]',      rendered = '󰨸 Tldr',      highlight = 'RenderMarkdownInfo',    category = 'obsidian' },
        info      = { raw = '[!INFO]',      rendered = '󰋽 Info',      highlight = 'RenderMarkdownInfo',    category = 'obsidian' },
        todo      = { raw = '[!TODO]',      rendered = '󰗡 Todo',      highlight = 'RenderMarkdownInfo',    category = 'obsidian' },
        hint      = { raw = '[!HINT]',      rendered = '󰌶 Hint',      highlight = 'RenderMarkdownSuccess', category = 'obsidian' },
        success   = { raw = '[!SUCCESS]',   rendered = '󰄬 Success',   highlight = 'RenderMarkdownSuccess', category = 'obsidian' },
        check     = { raw = '[!CHECK]',     rendered = '󰄬 Check',     highlight = 'RenderMarkdownSuccess', category = 'obsidian' },
        done      = { raw = '[!DONE]',      rendered = '󰄬 Done',      highlight = 'RenderMarkdownSuccess', category = 'obsidian' },
        question  = { raw = '[!QUESTION]',  rendered = '󰘥 Question',  highlight = 'RenderMarkdownWarn',    category = 'obsidian' },
        help      = { raw = '[!HELP]',      rendered = '󰘥 Help',      highlight = 'RenderMarkdownWarn',    category = 'obsidian' },
        faq       = { raw = '[!FAQ]',       rendered = '󰘥 Faq',       highlight = 'RenderMarkdownWarn',    category = 'obsidian' },
        attention = { raw = '[!ATTENTION]', rendered = '󰀪 Attention', highlight = 'RenderMarkdownWarn',    category = 'obsidian' },
        failure   = { raw = '[!FAILURE]',   rendered = '󰅖 Failure',   highlight = 'RenderMarkdownError',   category = 'obsidian' },
        fail      = { raw = '[!FAIL]',      rendered = '󰅖 Fail',      highlight = 'RenderMarkdownError',   category = 'obsidian' },
        missing   = { raw = '[!MISSING]',   rendered = '󰅖 Missing',   highlight = 'RenderMarkdownError',   category = 'obsidian' },
        danger    = { raw = '[!DANGER]',    rendered = '󱐌 Danger',    highlight = 'RenderMarkdownError',   category = 'obsidian' },
        error     = { raw = '[!ERROR]',     rendered = '󱐌 Error',     highlight = 'RenderMarkdownError',   category = 'obsidian' },
        bug       = { raw = '[!BUG]',       rendered = '󰨰 Bug',       highlight = 'RenderMarkdownError',   category = 'obsidian' },
        example   = { raw = '[!EXAMPLE]',   rendered = '󰉹 Example',   highlight = 'RenderMarkdownHint' ,   category = 'obsidian' },
        quote     = { raw = '[!QUOTE]',     rendered = '󱆨 Quote',     highlight = 'RenderMarkdownQuote',   category = 'obsidian' },
        cite      = { raw = '[!CITE]',      rendered = '󱆨 Cite',      highlight = 'RenderMarkdownQuote',   category = 'obsidian' },
        definition= { raw = '[!DEF]',       rendered = '📕 Definition',      highlight = 'RenderMarkdownQuote',   category = 'obsidian' },
        theorem   = { raw = '[!THM]',       rendered = '🧾 Theorem',      highlight = 'RenderMarkdownQuote',   category = 'obsidian' },
        example_a = { raw = '[!EX]',        rendered = '󰉹 Example',      highlight = 'RenderMarkdownQuote',   category = 'obsidian' },
        lemma     = { raw = '[!LMA]',       rendered = '🧾 Lemma',      highlight = 'RenderMarkdownQuote',   category = 'obsidian' },
        proof     = { raw = '[!PROOF]',     rendered = '🧾 Proof',      highlight = 'RenderMarkdownQuote',   category = 'obsidian' },
        proof_a   = { raw = '[!PRF]',     rendered = '🧾 Proof',      highlight = 'RenderMarkdownQuote',   category = 'obsidian' },
                -- stylua: ignore end
            },
        },
    },
    { "christoomey/vim-titlecase" },
    {
        "3rd/image.nvim",
        build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
        opts = {
            backend = "kitty",
            integrations = {
                markdown = {
                    floating_windows = true, -- if true, images will be rendered in floating markdown windows
                    enabled = false,
                    clear_in_insert_mode = true,
                    download_remote_images = true,
                    only_render_image_at_cursor = true,
                    only_render_image_at_cursor_mode = "popup", -- or "inline"
                },
            },
            tmux_show_only_in_active_window = true, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
        },
    },
    {
        "3rd/diagram.nvim",
        dependencies = {
            "3rd/image.nvim",
        },
        keys = {
            {
                "<leader>D", -- or any key you prefer
                function()
                    require("diagram").show_diagram_hover()
                end,
                mode = "n",
                desc = "Show diagram in new tab",
            },
        },
        opts = {
            events = {
                render_buffer = {}, -- Empty = no automatic rendering
                clear_buffer = { "BufLeave", "FocusLost" },
            },
            renderer_options = {
                mermaid = {
                    background = "transparent", -- nil | "transparent" | "white" | "#hex"
                    theme = "dark", -- nil | "default" | "dark" | "forest" | "neutral"
                    scale = 2, -- nil | 1 (default) | 2  | 3 | ...
                    -- cli_args = "--no-sandbox", -- nil | { "--no-sandbox" } | { "-p", "/path/to/puppeteer" } | ...
                },
            },
        },
    },
    {
        "obsidian-nvim/obsidian.nvim",
        version = "*", -- recommended, use latest release instead of latest commit
        lazy = true,
        ft = "BufReadPre " .. vim.fn.expand("~") .. "/.vaults/**/*.md",
        -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
        -- event = {
        --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
        --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
        --   -- refer to `:h file-pattern` for more examples
        --   "BufReadPre path/to/my-vault/*.md",
        --   "BufNewFile path/to/my-vault/*.md",
        -- },
        dependencies = {
            -- Required.
            "nvim-lua/plenary.nvim",

            -- see below for full list of optional dependencies 👇
        },
        opts = {
            ui = { enable = false },
            workspaces = {
                {
                    name = "personal",
                    path = "~/.vaults/personal",
                },
                {
                    name = "work",
                    path = "~/.vaults/work",
                },
            },

            -- see below for full list of options 👇
        },
    },
}
