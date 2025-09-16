vim.opt.timeoutlen = 500
vim.opt.compatible = false

vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.cmdheight = 1
vim.opt.cursorline = true -- Highlight the current row
vim.opt.title = true -- Set the window title based on what we're editing
vim.opt.autochdir = true -- Set the working directory to the file being edited
vim.opt.autoread = true -- Reload files if they change
vim.opt.showmode = false -- Light line handles this now
vim.opt.clipboard = "unnamedplus" -- yank and put from the keyboard
--vim.api.nvim_set_option("clipboard","unnamed") -- please
vim.api.nvim_set_option_value("signcolumn", "yes", { scope = "global" }) -- Keep the number column wide enough for signs always

-- Show borders on popups

-- Show whitespace
vim.opt.listchars = {
	--eol = '¬',
	eol = "↲",
	tab = ">·",
	trail = "~",
	extends = ">",
	precedes = "<",
}
vim.opt.list = true

-- Line numbers
vim.opt.number = true -- Show global line number for current line
vim.opt.relativenumber = true -- Show relative line numbers

-- Tab settings
local indent = 2 -- All our indents should be 2 characters
vim.opt.tabstop = indent
vim.opt.shiftwidth = indent
vim.opt.showtabline = indent
vim.opt.expandtab = false -- Don't replace tabs with sapces
vim.opt.smartindent = true -- Automatic indenting, see also 'cindent'

-- Python provider
local pynvim_env = "/.local/venv/nvim/"
vim.g.python3_host_prog = os.getenv("HOME") .. pynvim_env .. "/bin/python"

-- vim.g.markdown_fenced_languages = { "python", "zig" }

-- Disable netrw for nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Add custom filetypes
vim.filetype.add({
	extension = {
		dj = "djot",
		smk = "snakemake",
		pproj = "xml",
		p = "p",
		lus = "lus",
	},
	filename = {
		["Snakefile"] = "snakemake",
	},
})
