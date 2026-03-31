local map = vim.api.nvim_set_keymap
local wk = require("which-key")

options = { noremap = true, silent = true }

local function expand(arg)
    result = {}
    queue = { arg }

    item = table.remove(queue)
    while item do
        local children = item["children"]
        if children then
            for i, v in ipairs(children) do
                v["prefix"] = (item["prefix"] or "") .. (v["prefix"] or "")
                table.insert(queue, v)
            end

            local name = item["name"]

            if name then
                table.insert(result, { item["prefix"], group = name })
            end
        else
            item[1] = (item["prefix"] or "") .. item[1]
            item["prefix"] = nil
            table.insert(result, item)
        end

        item = table.remove(queue)
    end

    return result
end

local keymap = {
    prefix = "<leader>",
    children = {
        {
            prefix = "w",
            name = "windows",
            children = {
                { "/", ":vsplit <CR>", desc = "vertical split" },
                { "-", ":split <CR>", desc = "horizontal split" },
                { "d", ":close <CR>", desc = "delete window" },
            },
        },
        {
            prefix = "c",
            name = "config",
            children = {
                { "e", ":edit $MYVIMRC <CR>", desc = "edit config" },
                { "r", ":source $MYVIMRC <CR>", desc = "reload config" },
                { "R", ":source $MYVIMRC <CR> :PackerSync <CR>", desc = "reload config + install packages" },
            },
        },
        {
            prefix = "q",
            name = "quickfix",
            children = {
                { "n", ":cnext <CR>", desc = "next" },
                { "p", ":cprev <CR>", desc = "prev" },
                { "c", ":cclose <CR>", desc = "close" },
                { "N", ":lnext <CR>", desc = "next location" },
                { "P", ":lprev <CR>", desc = "prev location" },
                { "C", ":lclose <CR>", desc = "close location list" },
            },
        },
        { "#", "", desc = "window-#" },
    },
}

for i = 1, 9 do
    local binding = string.gsub("<leader>#", "#", i)
    local command = string.gsub(":#wincmd w<CR>", "#", i)
    map("n", binding, command, options)
    wk.add({ binding, command, hidden = true })
end

local low = function(i)
    return string.char(97 + i)
end
local upp = function(i)
    return string.char(65 + i)
end

for i = 0, 25 do
    vim.keymap.set("n", "m" .. low(i), "m" .. upp(i))
    vim.keymap.set("n", "m" .. upp(i), "m" .. low(i))
    vim.keymap.set("n", "'" .. low(i), "'" .. upp(i))
    vim.keymap.set("n", "'" .. upp(i), "'" .. low(i))
end

-- Move text up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move text down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move text up" })
vim.keymap.set({ "n", "v" }, "x", '"_x', { noremap = true })
vim.keymap.set({ "n", "v" }, "dd", '"_dd', { noremap = true })
vim.keymap.set({ "n", "v" }, "d", '"_d', { noremap = true })
vim.keymap.set({ "n", "v" }, "dd", '"_dd', { noremap = true })
vim.keymap.set({ "n", "v" }, "<C-x>", "d", { noremap = true })
vim.keymap.set({ "n", "v" }, "<C-xx>", "dd", { noremap = true })
vim.keymap.set({ "n", "v" }, "<C-z>", "<nop>", { noremap = true })

-- save file
vim.keymap.set({ "i", "n", "v" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

vim.api.nvim_create_user_command("Run", function(opts)
    vim.system(opts.fargs)
end, { nargs = "?" })

-- lazy
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- better indenting
map("x", "<", "<gv", {})
map("x", ">", ">gv", {})

-- windows
map("n", "<leader>-", "<C-W>s", { desc = "Split Window Below" })
map("n", "<leader>|", "<C-W>v", { desc = "Split Window Right" })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete Window" })

-- tabs
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>o", "<cmd>tabonly<cr>", { desc = "Close Other Tabs" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

vim.keymap.set({ "i", "n", "v" }, "<leader>uh", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle inlay hints" })

wk.add(expand(keymap))
