return {
	"esmuellert/nvim-eslint",
	ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	config = function()
		require("nvim-eslint").setup({})
	end,
}
