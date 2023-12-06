return {
	"https://github.com/SmiteshP/nvim-navic",
	dependencies = {
		"https://github.com/neovim/nvim-lspconfig",
		"https://github.com/onsails/lspkind.nvim",
	},
	init = function()
		vim.g.navic_silence = true
		require("utils").on_attach(function(client, bufnr)
			if client.server_capabilities.documentSymbolProvider then
				require("nvim-navic").attach(client, bufnr)
			end
		end)
	end,
	config = function()
		local symbol_map = {}
		for k, v in pairs(require("lspkind").symbol_map) do
			symbol_map[k] = v .. " "
		end

		require("nvim-navic").setup({
			icons = symbol_map,
			highlight = false,
			separator = " > ",
			depth_limit = 0,
			depth_limit_indicator = "..",
		})
	end,
}
