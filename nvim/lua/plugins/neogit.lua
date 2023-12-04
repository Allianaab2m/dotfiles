return {
	"https://github.com/NeogitOrg/neogit",
	dependencies = {
		"https://github.com/nvim-lua/plenary.nvim",
		"https://github.com/nvim-telescope/telescope.nvim",
	},
	cmd = "Neogit",
	keys = {
		{
			"<leader>gc",
			function()
				require("neogit").open({ "commit" })
			end,
			mode = "",
			desc = "Neogit status",
		},
		{
			"<leader>gs",
			function()
				require("neogit").open()
			end,
		},
	},
	opts = true,
}
