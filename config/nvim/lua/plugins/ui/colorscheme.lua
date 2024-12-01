return {
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
		opts = {},
		config = function()
			require("catppuccin").setup({
				color_overrides = {
					mocha = {
						base = "#000000",
					},
				},
				custom_highlights = function(c)
					return {
						CmpItemAbbrDeprecated = { fg = c.overlay0, bg = "NONE", strikethrough = true },
						CmpItemAbbrMatch = { fg = c.blue, bg = "NONE", bold = true },
						CmpItemAbbrMatchFuzzy = { fg = c.blue, bg = "NONE", bold = true },
						CmpItemMenu = { fg = c.flamingo, bg = "NONE", italic = true },

						CmpItemKindField = { fg = c.base, bg = c.red },
						CmpItemKindProperty = { fg = c.base, bg = c.red },
						CmpItemKindEvent = { fg = c.base, bg = c.red },

						CmpItemKindText = { fg = c.base, bg = c.green },
						CmpItemKindEnum = { fg = c.base, bg = c.green },
						CmpItemKindKeyword = { fg = c.base, bg = c.green },

						CmpItemKindConstant = { fg = c.base, bg = c.yellow },
						CmpItemKindConstructor = { fg = c.base, bg = c.yellow },
						CmpItemKindReference = { fg = c.base, bg = c.yellow },

						CmpItemKindFunction = { fg = c.base, bg = c.mauve },
						CmpItemKindStruct = { fg = c.base, bg = c.mauve },
						CmpItemKindClass = { fg = c.base, bg = c.mauve },
						CmpItemKindModule = { fg = c.base, bg = c.mauve },
						CmpItemKindOperator = { fg = c.base, bg = c.mauve },

						CmpItemKindVariable = { fg = c.base, bg = c.sky },
						CmpItemKindFile = { fg = c.base, bg = c.sky },

						CmpItemKindUnit = { fg = c.base, bg = c.peach },
						CmpItemKindSnippet = { fg = c.base, bg = c.peach },
						CmpItemKindFolder = { fg = c.base, bg = c.peach },

						CmpItemKindMethod = { fg = c.base, bg = c.blue },
						CmpItemKindValue = { fg = c.base, bg = c.blue },
						CmpItemKindEnumMember = { fg = c.base, bg = c.blue },

						CmpItemKindInterface = { fg = c.base, bg = c.lavender },
						CmpItemKindColor = { fg = c.base, bg = c.lavender },
						CmpItemKindTypeParameter = { fg = c.base, bg = c.lavender },
					}
				end,
			})
			vim.cmd([[colorscheme catppuccin]])
		end,
	},
}
