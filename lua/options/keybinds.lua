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


vim.api.nvim_create_user_command("Run", function(opts)
	vim.system(opts.fargs)
end, { nargs = "?" })

wk.add(expand(keymap))
