local function lsp_status()
    local attached_clients = vim.lsp.get_clients({ bufnr = 0 })
    if #attached_clients == 0 then
        return ""
    end
    local names = {}
    for _, client in ipairs(attached_clients) do
        local name = client.name:gsub("language.server", "ls")
        table.insert(names, name)
    end
    return "LSP: " .. table.concat(names, ", ")
end

local function macro()
    local reg = vim.fn.reg_recording()
    if reg == "" then
        return ""
    end
    return "Recording macro in: " .. reg
end

return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
        local dmode_enabled = false
        vim.api.nvim_create_autocmd("User", {
            pattern = "DebugModeChanged",
            callback = function(args)
                dmode_enabled = args.data.enabled
            end,
        })
        require("lualine").setup({
            options = {
                globalstatus = true,
            },
            sections = {
                lualine_a = {
                    {
                        "mode",
                        fmt = function(str)
                            return dmode_enabled and "DEBUG" or str
                        end,
                        color = function(tb)
                            return dmode_enabled and "dCursor" or tb
                        end,
                    },
                },
                lualine_b = {},
                lualine_c = {
                    { "filename", path = 4 },
                    { "diff" },
                    { "diagnostics" },
                    { macro },
                },
                lualine_x = {
                    {
                        "aerial",
                        -- The separator to be used to separate symbols in status line.
                        sep = " ) ",

                        -- The number of symbols to render top-down. In order to render only 'N' last
                        -- symbols, negative numbers may be supplied. For instance, 'depth = -1' can
                        -- be used in order to render only current symbol.
                        depth = 3,

                        -- When 'dense' mode is on, icons are not rendered near their symbols. Only
                        -- a single icon that represents the kind of current symbol is rendered at
                        -- the beginning of status line.
                        dense = false,

                        -- The separator to be used to separate symbols in dense mode.
                        dense_sep = ".",

                        -- Color the symbol icons.
                        colored = true,
                    },
                    { "filetype" },
                },
                lualine_y = { { "progress" }, { "location" } },
                lualine_z = {},
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { "filename" },
                lualine_x = { "location" },
                lualine_y = {},
                lualine_z = {},
            },
        })
    end,
}
