return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	disabled = false,
	cond = not is_vscode(),
	event = { "UiEnter", "ColorScheme" },
	opts = {
		transparent_background = true,
		lsp_styles = {
			virtual_text = {
				errors = { "italic" },
				hints = { "italic" },
				warnings = { "italic" },
				information = { "italic" },
				ok = { "italic" },
			},
			underlines = {
				errors = { "undercurl" },
				hints = { "undercurl" },
				warnings = { "undercurl" },
				information = { "undercurl" },
				ok = { "undercurl" },
			},
			inlay_hints = {
				background = true,
			},
		},
	},
	init = function()
		vim.api.nvim_create_autocmd("ColorScheme", {
			callback = function(args)
				if not vim.startswith(args.match, "catppuccin") then
					return
				end
				vim.g.colors_name = args.match
			end,
		})
	end,
	config = function(_, opts)
		local c = require("catppuccin")
		c.setup(opts)
		vim.cmd.colorscheme(vim.env.NVIM_COLORSCHEME)
	end,
}
