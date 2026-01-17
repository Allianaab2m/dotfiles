return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		lazygit = {},
	},
	keys = {
		{
			"<leader><space>",
			function()
				Snacks.picker.smart()
			end,
		},
		{
			"<leader>b",
			function()
				Snacks.picker.buffers()
			end,
		},
		{
			"<leader>/",
			function()
				Snacks.picker.grep()
			end,
		},
		{
			"<leader>f",
			function()
				Snacks.picker.files()
			end,
		},

		-- find
		{
			"<leader>ff",
			function()
				Snacks.picker.files()
			end,
		},
		{
			"<leader>fb",
			function()
				Snacks.picker.buffers()
			end,
		},
		{
			"<leader>fc",
			function()
				Snacks.picker.commands()
			end,
		},
		{
			"<leader>fp",
			function()
				Snacks.picker.projects()
			end,
		},
		{
			"<leader>fr",
			function()
				Snacks.picker.recent()
			end,
		},

		{
			"<leader>lg",
			function()
				Snacks.lazygit()
			end,
		},
	},
}
