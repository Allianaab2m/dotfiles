return {
	"filipjanevski/0x96f.nvim",
	priority = 1000,
	lazy = false,
	enabled = false,
	config = function()
		require("0x96f").setup()
		vim.cmd.colorscheme("0x96f")
	end,
}
