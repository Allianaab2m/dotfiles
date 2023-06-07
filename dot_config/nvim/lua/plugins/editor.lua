return {
	{
		"windwp/nvim-autopairs",
		event = { "InsertEnter" },
		opts = {},
	},
	{
		"vim-skk/skkeleton",
		event = { "InsertEnter" },
		config = function()
			require("denops-lazy").load("skkeleton")
			vim.keymap.set("i", "<C-j>", "<Plug>(skkeleton-toggle)")
			vim.fn["skkeleton#config"]({
				eggLikeNewline = true,
			})
		end,
	},
	{
		"numToStr/Comment.nvim",
		key = { "gcc", "gc" },
		opts = {},
	},
	{
		"ggandor/lightspeed.nvim",
		event = { "VeryLazy" },
		opts = {},
	},
}
