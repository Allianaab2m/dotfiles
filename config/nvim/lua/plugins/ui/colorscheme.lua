return {
	{
		"everviolet/nvim",
		name = "evergarden",
		priority = 1000, -- Colorscheme plugin is loaded first before any other plugins
		lazy = false,
		config = function()
			require("evergarden").setup({
				theme = {
					variant = "winter", -- 'winter'|'fall'|'spring'|'summer'
					accent = "green",
				},
				editor = {
					transparent_background = false,
					sign = { color = "none" },
					float = {
						color = "mantle",
						invert_border = false,
					},
					completion = {
						color = "surface0",
					},
				},
			})
			vim.cmd([[colorscheme evergarden]])
		end,
	},
	{
		"killitar/obscure.nvim",
		lazy = false,
		enabled = false,
		priority = 1000,
		config = function()
			require("obscure").setup({
				styles = {
					comments = { italic = true },
				},
				on_highlights = function(hl, c)
					hl.CmpItemAbbrDeprecated = { fg = c.gray3, bg = "NONE", strikethrough = true }
					hl.CmpItemAbbrMatch = { fg = c.blue, bg = "NONE", bold = true }
					hl.CmpItemAbbrMatchFuzzy = { fg = c.blue, bg = "NONE", bold = true }
					hl.CmpItemMenu = { fg = c.bright_magenta, bg = "NONE", italic = true }

					hl.CmpItemKindField = { fg = c.bg, bg = c.red }
					hl.CmpItemKindProperty = { fg = c.bg, bg = c.red }
					hl.CmpItemKindEvent = { fg = c.bg, bg = c.red }

					hl.CmpItemKindText = { fg = c.bg, bg = c.green }
					hl.CmpItemKindEnum = { fg = c.bg, bg = c.green }
					hl.CmpItemKindKeyword = { fg = c.bg, bg = c.green }

					hl.CmpItemKindConstant = { fg = c.bg, bg = c.yellow }
					hl.CmpItemKindConstructor = { fg = c.bg, bg = c.yellow }
					hl.CmpItemKindReference = { fg = c.bg, bg = c.yellow }

					hl.CmpItemKindFunction = { fg = c.bg, bg = c.magenta }
					hl.CmpItemKindStruct = { fg = c.bg, bg = c.magenta }
					hl.CmpItemKindClass = { fg = c.bg, bg = c.magenta }
					hl.CmpItemKindModule = { fg = c.bg, bg = c.magenta }
					hl.CmpItemKindOperator = { fg = c.bg, bg = c.magenta }

					hl.CmpItemKindVariable = { fg = c.bg, bg = c.cyan }
					hl.CmpItemKindFile = { fg = c.bg, bg = c.cyan }

					hl.CmpItemKindUnit = { fg = c.bg, bg = c.orange }
					hl.CmpItemKindSnippet = { fg = c.bg, bg = c.orange }
					hl.CmpItemKindFolder = { fg = c.bg, bg = c.orange }

					hl.CmpItemKindMethod = { fg = c.bg, bg = c.blue }
					hl.CmpItemKindValue = { fg = c.bg, bg = c.blue }
					hl.CmpItemKindEnumMember = { fg = c.bg, bg = c.blue }

					hl.CmpItemKindInterface = { fg = c.bg, bg = c.purple }
					hl.CmpItemKindColor = { fg = c.bg, bg = c.purple }
					hl.CmpItemKindTypeParameter = { fg = c.bg, bg = c.purple }
				end,
				highlight_overrides = {},
			})
			vim.cmd([[colorscheme obscure]])
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		enabled = false,
		opts = {},
		config = function()
			require("catppuccin").setup({
				custom_highlights = function(C)
					return {
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
					}
				end,
			})
			vim.cmd([[colorscheme catppuccin]])
		end,
	},
}
