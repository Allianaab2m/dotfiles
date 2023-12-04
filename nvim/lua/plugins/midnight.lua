return {
	"https://github.com/dasupradyumna/midnight.nvim",
	lazy = false,
	enabled = false,
	priority = 1000,
	opts = function()
		vim.cmd.colorscheme("midnight")
	end,
}
