return {
	{
		"rcarriga/nvim-notify",
		opts = {
			timeout = 3000,
			max_height = function()
				return math.floor(vim.o.lines * 0.75)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.75)
			end,
		},
		init = function()
			local Util = require("utils")
			if not Util.has("noice.nvim") then
				Util.on_very_lazy(function()
					vim.notify = require("notify")
				end)
			end
		end,
	},

	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
				},
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
			},
		},
	},

	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		opts = function()
			local icons = require("utils").icons.modes
			return {
				options = {
					theme = "auto",
					globalstatus = true,
					disabled_filetypes = { statusline = { "dashboard", "alpha" } },
				},
				sections = {
					lualine_a = {
						{
							"mode",
							fmt = function()
								return icons[vim.fn.mode()]
							end,
						},
					},
					lualine_b = {
						"branch",
					},
					lualine_c = {
						{ "diagnostics" },
						{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
						{ "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
						{
							function()
								return require("nvim-navic").get_location()
							end,
						},
					},
					lualine_x = {
						{ require("lazy.status").updates, cond = require("lazy.status").has_updates },
						{ "diff" },
					},
					lualine_y = {
						{ "progress", separator = " ", padding = { left = 1, right = 0 } },
						{ "location", padding = { left = 0, right = 1 } },
					},
					lualine_z = {},
				},
			}
		end,
	},

	{
		"stevearc/dressing.nvim",
		init = function()
			vim.ui.select = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.select(...)
			end
			vim.ui.input = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.input(...)
			end
		end,
	},

	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		opts = {
			options = {
				diagnostics = "nvim_lsp",
				always_show_bufferline = false,
				diagnostics_indicator = function(_, _, diag)
					local icons = require("utils").icons.diagnostics
					local ret = (diag.error and icons.Error .. diag.error .. " " or "")
						.. (diag.warning and icons.Warn .. diag.warning or "")
					return vim.trim(ret)
				end,
			},
		},
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			char = "│",
			filetype_exclude = { "help", "alphs", "dashboard", "neo-tree", "Trouble", "lazy" },
			show_trailing_blankline_indenx = false,
			show_current_context = false,
		},
	},

	{
		"SmiteshP/nvim-navic",
		init = function()
			vim.g.navic_silence =
				true, require("utils").on_attach(function(client, buffer)
					if client.server_capabilities.documentSymbolProvider then
						require("nvim-navic").attach(client, buffer)
					end
				end)
		end,
		opts = function()
			return {
				spearator = " ",
				highlight = true,
				depth_limit = 5,
				icons = require("utils").icons.kinds,
			}
		end,
	},

	{
		"nvim-tree/nvim-web-devicons",
		event = "VeryLazy",
		dependencies = "DaikyXendo/nvim-material-icon",
		config = function()
			require("nvim-web-devicons").setup({
				override = require("nvim-material-icon").get_icons(),
			})
		end,
	},

	{
		"MunifTanjim/nui.nvim",
	},
}
