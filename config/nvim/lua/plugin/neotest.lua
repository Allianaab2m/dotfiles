return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"antoinemadec/FixCursorHold.nvim",
		"marilari88/neotest-vitest",
	},
	cmd = { "Neotest" },
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-vitest"),
			},
		})
	end,
}
