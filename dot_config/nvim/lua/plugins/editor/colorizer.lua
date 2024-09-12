return {
	"norcalli/nvim-colorizer.lua",
	event = "VeryLazy",
	opts = function()
		require("colorizer").setup({ "*" })
		vim.cmd([[ColorizerToggle]])
	end,
}
