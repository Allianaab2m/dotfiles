return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
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
