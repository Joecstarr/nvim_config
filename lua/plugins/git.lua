return {
	{
		"f-person/git-blame.nvim",
		keys = {
			{ "<leader>gb", ":GitBlameToggle <CR>", desc = "blame" },
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},
}
