return {
	{
		"https://github.com/nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		version = "0.1.x",
		keys = {
			{ ";;", "<Cmd>Telescope<CR>", mode = "n", desc = "Telescope" },
			{ ";f", "<Cmd>Telescope find_files<CR>", mode = "n", desc = "Telescope find_files" },
			{ ";d", "<Cmd>Telescope file_browser<CR>", mode = "n", desc = "Telescope file_browser" },
			{ ";gs", "<Cmd>Telescope git_status<CR>", mode = "n", desc = "Telescope git_status" },
			{ ";gb", "<Cmd>Telescope git_branches<CR>", mode = "n", desc = "Telescope git_branches" },
			{ ";b", "<Cmd>Telescope buffers<CR>", mode = "n", desc = "Telescope buffers" },
		},
		dependencies = {
			"https://github.com/nvim-lua/plenary.nvim",
			"https://github.com/nvim-telescope/telescope-file-browser.nvim",
		},
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")
			telescope.setup({
				defaults = {
					mappings = {
						i = {
							["<Esc>"] = actions.close,
						},
						n = {
							["q"] = function(...)
								actions.close(...)
							end,
						},
					},
					layout_strategy = "vertical",
					layout_config = { prompt_position = "bottom" },
					sorting_strategy = "ascending",
					winblend = 0,
					borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
				},
				extensions = {
					file_browser = {
						layout_strategy = "horizontal",
					},
				},
			})

			require("telescope").load_extension("file_browser")
		end,
	},
}
