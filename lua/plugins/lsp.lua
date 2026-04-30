local function format_buffer()
    require("conform").format({
        async = true,
        lsp_format = "fallback",
    })
end

return {
    {
        "stevearc/conform.nvim",
        lazy = false,
        keys = { {
            "<leader>f",
            format_buffer,
            desc = "Format buffer",
        } },
        opts = {
            format_on_save = {
                -- These options will be passed to conform.format()
                timeout_ms = 500,
                lsp_format = "fallback",
            },
            formatters_by_ft = {
                lua = { "stylua" },
                nix = {
                    "nixpkgs_fmt",
                    stop_after_first = true,
                },
                python = { "ruff_format", "ruff_organize_imports" },
                tex = { "tex-fmt" },
                plaintex = { "tex-fmt" },
                markdown = { "myrumdl" },
                json = { "prettier" },
                yaml = { "prettier" },
                cmake = { "cmake_format" },
                toml = { "tombi" },
                c = { "myuncrustify" },
                cpp = { "myuncrustify" },
                janet = { "janet-format" },
                html = { "prettier" },
                javascript = { "prettier" },
                typescript = { "prettier" },
                astro = { "prettier" },
                jsx = { "prettier" },
                tsx = { "prettier" },
                typescriptreact = { "prettier" },
            },
            formatters = {
                myrumdl = {
                    command = "rumdl",
                    args = function(_, ctx)
                        local args = { "fmt", "--config" }
                        -- Find rumdl in the project if it exists
                        local cfg_path = vim.fs.find(".rumdl.toml", { upward = true, path = ctx.dirname })[1]
                        if cfg_path then
                            table.insert(args, cfg_path)
                        else
                            table.insert(args, "~/.rumdl.toml")
                        end
                        table.insert(args, "-")
                        return args
                    end,
                    stdin = true,
                },
                mymdformat = {
                    command = "mdformat",
                    args = function(_, ctx)
                        local args = { "-", "--no-validate" }
                        return args
                    end,
                    stdin = true,
                },
                myuncrustify = {
                    command = "uncrustify",
                    args = function(_, ctx)
                        local args = { "-q", "-l", vim.bo[ctx.buf].filetype:upper() }

                        -- Find uncrustify.cfg in the project if it exists
                        local cfg_path = vim.fs.find(".uncrustify.cfg", { upward = true, path = ctx.dirname })[1]
                        if cfg_path then
                            table.insert(args, "-c")
                            table.insert(args, cfg_path)
                        end
                        return args
                    end,
                    stdin = true,
                },
                nix = {
                    command = "nix",
                    args = { "fmt", "$FILENAME" },
                    stdin = false,
                },
                nixpkgs_fmt = {
                    command = "nixfmt",
                    stdin = true,
                },
                gleam = {
                    cmd = "gleam",
                    args = { "format", "--stdin" },
                    stdin = true,
                },
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = { "saghen/blink.cmp" },
        lazy = false,
        opts = {
            inlay_hints = { enabled = false },
            servers = {
                ruff = {},
                astro = {},
                -- marksman = {},
                markdown_oxide = {},
                harper_ls = {
                    linters = {
                        SentenceCapitalization = false,
                        SpellCheck = true,
                        SpelledNumbers = false,
                        AnA = true,
                        UnclosedQuotes = true,
                        WrongQuotes = false,
                        LongSentences = true,
                        RepeatedWords = true,
                        Spaces = false,
                        Matcher = true,
                        CorrectNumberSuffix = true,
                    },
                    markdown = {
                        IgnoreLinkTitle = false,
                    },
                    maxFileLength = 120000,
                    userDictPath = "~/.config/nvim/harper/dictionaries/user.txt",
                    fileDictPath = "~/.config/nvim/harper/dictionaries/files/",
                    ignoredLintsPath = "~/.config/nvim/harper/ignoredLints/",
                },
                clangd = {
                    mason = false,
                    keys = {
                        { "<leader>ch", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
                    },
                    root_markers = {
                        "compile_commands.json",
                        "compile_flags.txt",
                        "configure.ac", -- AutoTools
                        "Makefile",
                        "configure.ac",
                        "configure.in",
                        "config.h.in",
                        "meson.build",
                        "meson_options.txt",
                        "build.ninja",
                        ".git",
                    },
                    init_options = {
                        usePlaceholders = true,
                        completeUnimported = true,
                        clangdFileStatus = true,
                    },
                },
                neocmakelsp = {},
                lua_ls = {},
                pyright = {},
                rust_analyzer = {},
                gleam = {},
                toml = {},
                janet = {},
                ltex_plus = {
                    additionalRules = {
                        enablePickyRules = true,
                    },
                    markdown = {
                        nodes = {
                            CodeBlock = "default",
                            FencedCodeBlock = "default",
                            IndentedCodeBlock = "default",
                            AutoLink = "default",
                            BlockQuote = "default",
                            Code = "default",
                            Block = "default",
                        },
                    },
                    statusBarItem = true,
                    language = "en-US",
                    diagnosticSeverity = { default = "warning" },
                    enabled = {
                        "markdown",
                        "plaintex",
                        "rst",
                        "tex",
                        "c",
                        "latex",
                        "gitcommit",
                        "mail",
                        "norg",
                        "org",
                        "pandoc",
                        "text",
                        "toml",
                    },
                    languageToolHttpServerUri = "http://localhost:6767",
                    checkFrequency = "save",
                },
                -- use LanguageTool via ltex for spell checking
                -- TODO: https://dev.languagetool.org/finding-errors-using-n-gram-data.html
            },
        },
        config = function(_, opts)
            -- TODO not super thrilled with this but it works for now
            local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview

            ---@diagnostic disable-next-line: duplicate-set-field
            function vim.lsp.util.open_floating_preview(contents, syntax, _opts, ...)
                _opts = _opts or {}
                _opts.border = "rounded"
                return orig_util_open_floating_preview(contents, syntax, _opts, ...)
            end

            vim.diagnostic.config({ virtual_text = true })
            vim.lsp.inlay_hint.enable(true)

            for server, config in pairs(opts.servers) do
                vim.lsp.enable(server)

                config.on_attach = function(client, bufnr)
                    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
                    vim.keymap.set("n", "<leader>lk", vim.lsp.buf.hover, { desc = "Hover" })
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
                    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
                end
                vim.lsp.config(server, config)
            end
        end,
    },
    {
        "barreiroleo/ltex_extra.nvim",
        branch = "dev",
        dependencies = { "neovim/nvim-lspconfig" },
        opts = {
            load_langs = { "en-US" },
            init_check = true, -- whether to load dictionaries on startup
            path = "~/.config/nvim/spell", -- path to store dictionaries.
        },
    },
    {
        "numToStr/Comment.nvim",
        lazy = false,
    },

    {
        "smjonas/inc-rename.nvim",
        opts = {
            input_buffer_type = "snacks",
        },
        setup = {
            vim.keymap.set("n", "<leader>rn", function()
                return ":IncRename " .. vim.fn.expand("<cword>")
            end, { expr = true }),
        },
    },
}
