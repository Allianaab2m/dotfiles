return {
	"rachartier/tiny-code-action.nvim",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{
			"folke/snacks.nvim",
			opts = {
				terminal = {},
			},
		},
	},
	event = "LspAttach",
	opts = {
		backend = "delta",
		backend_opts = {
			delta = {
				header_lines_to_remove = 4,
				args = {},
			},
		},
	},
}
