return {
	"akinsho/bufferline.nvim",
	event = "VeryLazy",
	keys = {
		{
			"<S-h>",
			"<Cmd>BufferLineCyclePrev<CR>",
			desc = "Prev Buffer",
		},
		{
			"<S-l>",
			"<Cmd>BufferLineCycleNext<CR>",
			desc = "Next Buffer",
		},
	},
	opts = {
		options = {
			diagnostics = "nvim_lsp",
			always_show_bufferline = true,
			diagnostics_indicator = function(_, _, diag)
				local icons = require("utils").icons.diagnostics
				local ret = (diag.error and icons.Error .. diag.error .. " " or "")
					.. (diag.warning and icons.Warn .. diag.warning .. " " or "")
					.. (diag.info and icons.Info .. diag.info or "")
				return vim.trim(ret)
			end,
			offsets = {
				{
					filetype = "neo-tree",
					text = "Neotree",
					highlight = "Directory",
					text_align = "left",
				},
			},
		},
	},
	config = function(_, opts)
		require("bufferline").setup(opts)
		vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
			callback = function()
				vim.schedule(function()
					pcall(nvim_bufferline)
				end)
			end,
		})
	end,
}
