return {
	"https://github.com/akinsho/bufferline.nvim",
	event = "VeryLazy",
	config = function()
		require("bufferline").setup({
			options = {
				diagnostics = "nvim_lsp",
				mode = "buffers",
				diagnostics_indicator = function(count, level, diagnostics_dict, context)
					local s = " "
					for e, n in pairs(diagnostics_dict) do
						local sym = e == "error" and " " or (e == "warning" and " " or "")
						s = s .. n .. sym
					end
					return s
				end,
			},
			highlights = {},
		})
	end,
}
