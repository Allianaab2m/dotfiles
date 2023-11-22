local function lualine_lspnames()
	local clients = {}
	for _, client in ipairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
		table.insert(clients, client.name)
	end
	return " " .. table.concat(clients, ", ")
end

return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			views = {
				cmdline_popup = {
					position = {
						row = 5,
						col = "50%",
					},
					size = {
						width = 60,
						height = "auto",
					},
					border = {
						style = "single",
					},
				},
				popupmenu = {
					relative = "editor",
					position = {
						row = 8,
						col = "50%",
					},
					size = {
						width = 60,
						height = 10,
					},
					border = {
						style = "single",
						padding = { 0, 1 },
					},
					win_options = {
						winhighlight = { Normal = "Normal", FloatBorder = "MoreMsg" },
					},
				},
			},
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
				},
				presets = {
					bottom_search = true,
					command_palette = true,
					long_message_to_split = true,
				},
			},
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
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
				},
				sections = {
					lualine_a = {
						{
							"mode",
							fmt = function()
								return icons[vim.fn.mode()]
							end,
							color = { bg = "#202023", fg = "#97A4B5" },
							separator = { right = "" },
						},
					},
					lualine_b = {
						{ "branch" },
					},
					lualine_c = {
						{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
						{ "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
						{ "diagnostics" },
					},
					lualine_x = {
						lualine_lspnames,
						-- skkeleton_indicator,
						{ require("lazy.status").updates, cond = require("lazy.status").has_updates },
						{ "diff" },
						{ "datetime", style = "%m/%d %H:%M" },
					},
					lualine_y = {
						{ "progress", separator = " ", padding = { left = 1, right = 0 } },
						{ "location", padding = { left = 0, right = 1 } },
					},
					lualine_z = {},
				},
				winbar = {
					lualine_c = {
						{
							"navic",
							color_correction = nil,
							navic_opts = nil,
						},
					},
				},
			}
		end,
	},
	{
		"akinsho/bufferline.nvim",
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
	},
	{
		"nvim-tree/nvim-web-devicons",
		event = "VeryLazy",
		config = function()
			require("nvim-web-devicons").setup({})
		end,
	},
	{
		"RRethy/vim-illuminate",
		init = function()
			vim.g.Illuminate_delay = 500
			require("utils").on_attach(function(client, bufnr)
				require("illuminate").on_attach(client)
			end)
		end,
	},
	{
		"SmiteshP/nvim-navic",
		dependencies = {
			"neovim/nvim-lspconfig",
			"onsails/lspkind.nvim",
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
	},
	{
		"stevearc/dressing.nvim",
		opts = {},
		lazy = false,
	},
	{
		"akinsho/toggleterm.nvim",
		cmd = "ToggleTerm",
		keys = {
			{
				"<leader>t",
				function()
					vim.cmd([[ToggleTerm]])
				end,
				mode = "",
				desc = "",
			},
		},
		opts = true,
	},
}
