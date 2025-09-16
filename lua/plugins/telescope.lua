local live_grep = function()
	require("telescope.builtin").live_grep({
		cwd = require("util").get_root(),
	})
end

return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},

		cmd = {
			"Telescope",
		},

		keys = {
			{ "<leader>tf", require("telescope.builtin").git_files, desc = "Find files" },
			{ "<leader>tg", live_grep, desc = "Grep" },
			{ "<leader>td", require("telescope.builtin").diagnostics, desc = "Diagnostics" },
			{ "<leader>th", require("telescope.builtin").help_tags, desc = "Help" },
		},

		config = function()
			local actions = require("telescope.actions")
			-- TODO I would rather just detect if there is a selection and if so send
			-- that to the quickfix list but this was easier for right now.
			require("telescope").setup({
				defaults = {
					results_title = false,
					layout_strategy = "vertical",
					mappings = {
						i = {
							["<C-A>"] = actions.select_all,
							["<C-Q>"] = actions.send_selected_to_qflist + actions.open_qflist,
						},
					},
				},
			})
		end,
	},
	{
		"nvim-telescope/telescope-bibtex.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		keys = {
			{ "<leader>tb", ":Telescope buffers<cr>", desc = "List buffers" },
		},
		config = function()
			require("telescope").load_extension("bibtex")
		end,
	},
}
