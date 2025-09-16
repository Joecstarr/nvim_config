return {
	"echasnovski/mini.files",
	version = "*",
	config = function()
		require("mini.files").setup()
	end,
	keys = {
		{
			"<leader>e",
			function()
				require("mini.files").open()
			end,
			desc = "filetree",
		},
	},
}
