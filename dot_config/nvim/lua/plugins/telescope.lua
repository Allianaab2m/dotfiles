return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	version = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			dir = [[~/ghq/github.com/Allianaab2m/telescope-kensaku.nvim]],
			dependencies = {
				"vim-denops/denops.vim",
				"lambdalisue/kensaku.vim",
			},
			config = function()
				require("telescope").load_extension("kensaku")
			end,
		},
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
				layout_strategy = "horizontal",
				layout_config = { prompt_position = "top" },
				sorting_strategy = "ascending",
				winblend = 0,
				borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
			},
		})
	end,
}
