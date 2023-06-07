return {
	{
		"nvim-lua/plenary.nvim",
	},
	{
		"vim-denops/denops.vim",
		event = { "VeryLazy" },
	},
	{
		"lambdalisue/kensaku.vim",
		dependencies = {
			"vim-denops/denops.vim",
		},
		config = function()
			require("denops-lazy").load("kensaku.vim")
		end,
	},
	{
		"yuki-yano/denops-lazy.nvim",
		lazy = false,
	},
}
