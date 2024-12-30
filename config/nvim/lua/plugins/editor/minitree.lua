return {
	"echasnovski/mini.files",
	version = false,
	keys = {
		{
			"<leader>e",
			desc = "Explorer mini.files",
			function()
				require("mini.files").open()
			end,
		},
	},
}
