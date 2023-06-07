return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavor = "mocha",
				no_italic = false,
				no_bold = false,
				styles = {
					comments = { "italic" },
					keywords = { "bold" },
				},
				color_overrides = {
					mocha = {
						base = "#11111b",
						mantle = "#11111b",
						crust = "#11111b",
					},
				},
				highlight_overrides = {
					mocha = function(C)
						return {
							CmpBorder = { fg = C.surface2 },
							CmpItemKindSnippet = { fg = C.base, bg = C.mauve },
							CmpItemKindKeyword = { fg = C.base, bg = C.red },
							CmpItemKindText = { fg = C.base, bg = C.teal },
							CmpItemKindMethod = { fg = C.base, bg = C.blue },
							CmpItemKindConstructor = { fg = C.base, bg = C.blue },
							CmpItemKindFunction = { fg = C.base, bg = C.blue },
							CmpItemKindFolder = { fg = C.base, bg = C.blue },
							CmpItemKindModule = { fg = C.base, bg = C.blue },
							CmpItemKindConstant = { fg = C.base, bg = C.peach },
							CmpItemKindField = { fg = C.base, bg = C.green },
							CmpItemKindProperty = { fg = C.base, bg = C.green },
							CmpItemKindEnum = { fg = C.base, bg = C.green },
							CmpItemKindUnit = { fg = C.base, bg = C.green },
							CmpItemKindClass = { fg = C.base, bg = C.yellow },
							CmpItemKindVariable = { fg = C.base, bg = C.flamingo },
							CmpItemKindFile = { fg = C.base, bg = C.blue },
							CmpItemKindInterface = { fg = C.base, bg = C.yellow },
							CmpItemKindColor = { fg = C.base, bg = C.red },
							CmpItemKindReference = { fg = C.base, bg = C.red },
							CmpItemKindEnumMember = { fg = C.base, bg = C.red },
							CmpItemKindStruct = { fg = C.base, bg = C.blue },
							CmpItemKindValue = { fg = C.base, bg = C.peach },
							CmpItemKindEvent = { fg = C.base, bg = C.blue },
							CmpItemKindOperator = { fg = C.base, bg = C.blue },
							CmpItemKindTypeParameter = { fg = C.base, bg = C.blue },
							CmpItemKindCopilot = { fg = C.base, bg = C.teal },
						}
					end,
				},
			})
			vim.cmd.colorscheme("catppuccin")
			vim.cmd([[ hi DiagnosticUnderlineError gui=undercurl ]])
			vim.cmd([[ hi DiagnosticUnderlineWarn gui=undercurl ]])
			vim.cmd([[ hi DiagnosticUnderlineInfo gui=undercurl ]])
			vim.cmd([[ hi DiagnosticUnderlineHint gui=undercurl ]])
		end,
	},
}
