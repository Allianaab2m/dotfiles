--@type LazySpec
return {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {},
	enabled = false,
	cond = not is_vscode(),
	keys = {
		{ "<leader>e", "<cmd>Oil<cr>", desc = "Open Oil" },
	},
	dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
	-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
	lazy = false,
}
