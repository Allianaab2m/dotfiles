return {
	{
		"dasupradyumna/midnight.nvim",
		lazy = false,
		enabled = false,
		priority = 1000,
		opts = function()
			vim.cmd.colorscheme("midnight")
		end,
	},
	{
		"cocopon/iceberg.vim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("iceberg")
		end,
	},
}
