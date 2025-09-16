require("which-key").add({ "<leader>z", group = "zettle" })

return {
	"renerocksai/telekasten.nvim",

	dependencies = {
		"nvim-telescope/telescope.nvim",
	},

	keys = {
		{
			"<leader>zn",
			function()
				require("telekasten").new_note()
			end,
			desc = "Create a new note",
		},
		{
			"<leader>zf",
			function()
				require("telekasten").find_notes()
			end,
			desc = "Find note",
		},
		{
			"<leader>zs",
			function()
				require("telekasten").search_notes()
			end,
			desc = "Search note",
		},
		{
			"<leader>zg",
			function()
				require("telekasten").follow_link()
			end,
			desc = "Follow link",
		},
		{
			"<leader>zd",
			function()
				require("telekasten").goto_today()
			end,
			desc = "Open today's notes",
		},
		{
			"<leader>zw",
			function()
				require("telekasten").goto_thisweek()
			end,
			desc = "Open this weeks notes",
		},
		{
			"<leader>zl",
			function()
				require("telekasten").insert_link()
			end,
			desc = "Insert a link",
		},
		{
			"<leader>zp",
			function()
				require("telekasten").panel()
			end,
			desc = "Insert a link",
		},
		{
			"<leader>zt",
			function()
				require("telekasten").show_tags()
			end,
			desc = "Show tags",
		},
	},

	config = function()
		local telekasten = require("telekasten")

		local home = "/home/joe/notes"
		local templates = home .. "/templates"

		telekasten.setup({
			-- Where are things located
			home = home,
			dailies = home .. "/daily",
			weeklies = home .. "/weekly",
			templates = templates,

			-- Templates
			template_new_note = templates .. "/new_note.md",
			template_new_daily = templates .. "/new_daily.md",
			template_new_weekly = templates .. "/new_weekly.md",

			-- Note Creation
			new_note_filename = "title",

			-- Don't use the calendar
			plug_into_calendar = false,

			-- Open a new window
			command_palette_theme = "dropdown",
			show_tags_theme = "dropdown",

			-- Tags
			tag_notation = "yaml-bare",

			-- Use standard markdown stuff
			take_over_my_home = false,
			auto_set_filetype = false,
			auto_set_syntax = false,
			extension = ".md",
			install_syntax = false,
		})
	end,
}
