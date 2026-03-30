local M = {}

local use_theme = function(name)
    local ok, err = pcall(vim.cmd.colorscheme, name)

    return ok
end

M.colorscheme_conf = {
    dp = function()
        use_theme("dracula_pro")
    end,
    dracula = function()
        use_theme("dracula")
    end,
}

M.set_colorscheme = function()
    for key, value in pairs(M.colorscheme_conf) do
        if value() then
            break
        end
    end
end

M.set_colorscheme()

return M
