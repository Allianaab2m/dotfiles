return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = "VeryLazy",
	dependencies = {
		"windwp/nvim-ts-autotag",
		"nvim-treesitter/playground",
	},

	config = function()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			playglound = {
				enable = true,
			},
			ensure_installed = {
				"c",
				"lua",
				"typescript",
				"javascript",
				"vim",
				"markdown",
				"markdown_inline",
				"comment",
			},
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
			autotag = { enable = true },
		})
	end,
}
