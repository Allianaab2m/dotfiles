return {
	{
		"killitar/obscure.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			local colors = require("obscure.palettes").get_palette("obscure")
			require("obscure").setup({
				styles = {
					comments = { italic = true },
				},
				highlight_overrides = {
					CmpItemAbbrDeprecated = { fg = colors.gray3, bg = "NONE", strikethrough = true },
					CmpItemAbbrMatch = { fg = colors.blue, bg = "NONE", bold = true },
					CmpItemAbbrMatchFuzzy = { fg = colors.blue, bg = "NONE", bold = true },
					CmpItemMenu = { fg = colors.bright_magenta, bg = "NONE", italic = true },

					CmpItemKindField = { fg = colors.bg, bg = colors.red },
					CmpItemKindProperty = { fg = colors.bg, bg = colors.red },
					CmpItemKindEvent = { fg = colors.bg, bg = colors.red },

					CmpItemKindText = { fg = colors.bg, bg = colors.green },
					CmpItemKindEnum = { fg = colors.bg, bg = colors.green },
					CmpItemKindKeyword = { fg = colors.bg, bg = colors.green },

					CmpItemKindConstant = { fg = colors.bg, bg = colors.yellow },
					CmpItemKindConstructor = { fg = colors.bg, bg = colors.yellow },
					CmpItemKindReference = { fg = colors.bg, bg = colors.yellow },

					CmpItemKindFunction = { fg = colors.bg, bg = colors.magenta },
					CmpItemKindStruct = { fg = colors.bg, bg = colors.magenta },
					CmpItemKindClass = { fg = colors.bg, bg = colors.magenta },
					CmpItemKindModule = { fg = colors.bg, bg = colors.magenta },
					CmpItemKindOperator = { fg = colors.bg, bg = colors.magenta },

					CmpItemKindVariable = { fg = colors.bg, bg = colors.cyan },
					CmpItemKindFile = { fg = colors.bg, bg = colors.cyan },

					CmpItemKindUnit = { fg = colors.bg, bg = colors.orange },
					CmpItemKindSnippet = { fg = colors.bg, bg = colors.orange },
					CmpItemKindFolder = { fg = colors.bg, bg = colors.orange },

					CmpItemKindMethod = { fg = colors.bg, bg = colors.blue },
					CmpItemKindValue = { fg = colors.bg, bg = colors.blue },
					CmpItemKindEnumMember = { fg = colors.bg, bg = colors.blue },

					CmpItemKindInterface = { fg = colors.bg, bg = colors.purple },
					CmpItemKindColor = { fg = colors.bg, bg = colors.purple },
					CmpItemKindTypeParameter = { fg = colors.bg, bg = colors.purple },
				},
			})
			vim.cmd([[colorscheme obscure]])
		end,
	},
	{
		"catppuccin/nvim",
		enabled = false,
		name = "catppuccin",
		priority = 1000,
		opts = {},
	},
}
