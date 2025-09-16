return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	-- Lazy config causes weird issues which I don't wanna debug
	lazy = false,
	config = function()
		local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

		parser_config.lustre = {
			install_info = {
				url = "https://github.com/Arxwel/tree-sitter-lustre",
				files = { "src/parser.c" },
				requires_generate_from_grammar = false,
			},
			filetype = "lus",
		}

		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"css",
				"djot",
				"javascript",
				"lua",
				"typescript",
				"snakemake",
				"gleam",
				"nix",
				"python",
				"vimdoc",
				"markdown", -- LSPsaga
				"markdown_inline", -- LSPsaga
			},
			highlight = {
				enable = true,
				disable = { "markdown" },

				-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
				additional_vim_regex_highlighting = false,
			},
		})
	end,
}
