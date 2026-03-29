return {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",

    config = function()
        local ls = require("luasnip")
        local s = ls.snippet
        local t = ls.text_node
        local i = ls.insert_node
        local rep = require("luasnip.extras").rep
        local fmta = require("luasnip.extras.fmt").fmta
        local fmt = require("luasnip.extras.fmt").fmt

        vim.keymap.set({ "i", "s" }, "<C-L>", function()
            ls.jump(1)
        end, { silent = true })
        vim.keymap.set({ "i", "s" }, "<C-J>", function()
            ls.jump(-1)
        end, { silent = true })

        ls.add_snippets("lua", { s("print_str", { t('print("'), i(1, "desrc"), t('")') }) })
        ls.add_snippets("tex", {
            s(
                "\\begin",
                fmta(
                    [[
                        \begin{<env_start>}
                          <finish>
                        \end{<env_end>}
                    ]],
                    {
                        env_start = i(1, "env"),
                        env_end = rep(1),
                        finish = i(0),
                    }
                )
            ),
        })
        ls.add_snippets("lus", {
            s(
                "opt",
                fmt([[Option<{type}>{finish}]], {
                    type = i(1, "type"),
                    finish = i(0),
                })
            ),
            s(
                "some",
                fmt([[OptSome@<{type}>({value}){finish}]], {
                    type = i(1, "type"),
                    value = i(2, "value"),
                    finish = i(0),
                })
            ),
            s(
                "none",
                fmt([[OptNone@<{type}>(){finish}]], {
                    type = i(1, "type"),
                    finish = i(0),
                })
            ),
        })
    end,
}
