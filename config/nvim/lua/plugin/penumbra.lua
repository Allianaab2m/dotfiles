return {
	"Allianaab2m/penumbra.nvim",
	priority = 1000,
	lazy = false,
	enabled = false,
	config = function()
		local penumbra = require("penumbra")
		penumbra.setup({
			contrast = "plusplus",
			italic_comment = true,
		})
		vim.cmd.colorscheme(vim.env.NVIM_COLORSCHEME)
	end,
}
