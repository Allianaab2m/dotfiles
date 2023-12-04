return {
	"https://github.com/feline-nvim/feline.nvim",
	lazy = false,
	config = function()
		require("feline").setup({
			components = require("catppuccin.groups.integrations.feline").get(),
		})
		vim.api.nvim_create_autocmd("ColorScheme", {
			pattern = "*",
			callback = function()
				package.loaded["feline"] = nil
				package.loaded["catppuccin.groups.integrations.feline"] = nil
				require("feline").setup({
					components = require("catppuccin.groups.integrations.feline").get(),
				})
			end,
		})
	end,
}
