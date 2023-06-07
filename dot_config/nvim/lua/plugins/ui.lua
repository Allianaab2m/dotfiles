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
				presets = {
					bottom_search = true,
					command_palette = true,
					long_message_to_split = true,
				},
			},
		},
	},
	{
		"akinsho/toggleterm.nvim",
		cmd = "ToggleTerm",
		version = "*",
		opts = true,
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		opts = function()
			local icons = require("utils").icons.modes
			local lsp_names = function()
				local clients = {}
				for _, client in ipairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
					if client.name == "null-ls" then
						local sources = {}
						for _, source in ipairs(require("null-ls.sources").get_available(vim.bo.filetype)) do
							table.insert(sources, source.name)
						end
						table.insert(clients, "null-ls(" .. table.concat(sources, ", ") .. ")")
					else
						table.insert(clients, client.name)
					end
				end
				return " " .. table.concat(clients, ", ")
			end

			local skkeleton_indicator = function()
				if vim.fn["skkeleton#is_enabled"]() == true then
					local base = "▼ "
					local mode = vim.fn["skkeleton#mode"]()
					if mode == "hira" then
						return base .. "ひら"
					elseif mode == "kata" then
						return base .. "カタ"
					else
						return base
					end
				else
					return "▽ OFF"
				end
			end

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
						},
					},
					lualine_b = {
						"branch",
					},
					lualine_c = {
						{ "diagnostics" },
						{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
						{ "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
					},
					lualine_x = {
						lsp_names,
						skkeleton_indicator,
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
		"nvim-tree/nvim-web-devicons",
		event = "VeryLazy",
		dependencies = {
			"DaikyXendo/nvim-material-icon",
		},
		config = function()
			require("nvim-web-devicons").setup({
				override = require("nvim-material-icon").get_icons(),
			})
		end,
	},
	{
		"akinsho/bufferline.nvim",
		event = { "BufReadPost" },
		opts = {
			options = {
				diagnostics = "nvim_lsp",
				separator_style = "slant",
				indicator = {
					style = "underline",
				},
				close_command = "Bdelete! %d",
				diagnostics_indicator = function(count, _, _, _)
					if count > 9 then
						return "9+"
					end
					return tostring(count)
				end,
				offsets = {
					{
						filetype = "neo-tree",
						text = "Explorer",
						text_align = "center",
					},
				},
				hover = {
					enabled = true,
					delay = 0,
					reveal = { "close" },
				},
			},
		},
	},
	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		cmd = "Barbecue",
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons",
		},
		opts = function()
			vim.api.nvim_create_autocmd({
				"WinScrolled",
				"BufWinEnter",
				"CursorHold",
				"InsertLeave",
			}, {
				group = vim.api.nvim_create_augroup("barbecue.updater", {}),
				callback = function()
					require("barbecue.ui").update()
				end,
			})
			return {
				theme = "catppuccin",
				create_autocmd = false,
			}
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		version = "v2.*",
		cmd = "Neotree",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
			{
				"s1n7ax/nvim-window-picker",
				opts = {
					autoselect_one = true,
					include_current = false,
					filter_rules = {
						bo = {
							filetype = { "neo-tree", "neo-tree-popup", "notify" },
							buftype = { "terminal", "quickfix" },
						},
					},
				},
			},
		},
		opts = {
			close_if_last_window = false,
			popup_border_style = "single",
			enable_git_status = true,
			enable_diagnostics = true,
			open_files_do_not_replace_types = { "teminal", "trouble", "qf" },
			sort_case_insensitive = false,
			source_selector = {
				winbar = true,
			},
			default_component_configs = {
				container = {
					enable_character_fade = true,
				},
				indent = {
					indent_size = 2,
					padding = 1,
					with_markers = true,
					indent_marker = "│",
					last_indent_marker = "└",
					highlight = "NeoTreeIndentMarker",
					-- expander config, needed for nesting files
					with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
					expander_collapsed = "",
					expander_expanded = "",
					expander_highlight = "NeoTreeExpander",
				},
				icon = {
					folder_closed = "",
					folder_open = "",
					folder_empty = "ﰊ",
					-- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
					-- then these will never be used.
					default = "*",
					highlight = "NeoTreeFileIcon",
				},
				modified = {
					symbol = "[+]",
					highlight = "NeoTreeModified",
				},
				name = {
					trailing_slash = false,
					use_git_status_colors = true,
					highlight = "NeoTreeFileName",
				},
				git_status = {
					symbols = {
						-- Change type
						added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
						modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
						deleted = "✖", -- this can only be used in the git_status source
						renamed = "", -- this can only be used in the git_status source
						-- Status type
						untracked = "",
						ignored = "",
						unstaged = "",
						staged = "",
						conflict = "",
					},
				},
			},
			commands = {},
			window = {
				position = "left",
				width = 30,
				mapping_options = {
					noremap = true,
					nowait = true,
				},
				mappings = {
					["<Space>"] = {
						"toggle_node",
						nowait = false,
					},
					["<CR>"] = "open",
					["<Esc>"] = "revert_preview",
					["P"] = { "toggle_preview", config = { use_float = true } },
					["l"] = "focus_preview",
					["w"] = "open_with_window_picker",
					["a"] = {
						"add",
						config = {
							show_path = "relative",
						},
					},
					["A"] = "add_directory",
					["d"] = "delete",
					["r"] = "rename",
					["y"] = "copy_to_clipboard",
					["x"] = "cut_to_clipboard",
					["p"] = "paste_from_clipboard",
					["c"] = "copy",
					["m"] = "move",
					["q"] = "close_window",
					["R"] = "refresh",
					["?"] = "show_help",
				},
			},
			filesystem = {
				filtered_items = {
					visible = false,
					hide_dotfiles = true,
					hide_gitignored = true,
					hide_hiddent = true,
					always_show = {
						".gitignore",
					},
				},
				follow_current_file = false,
				group_empty_dirs = true,
				hijack_netrw_behavior = "open_default",
				use_libuv_file_watcher = false,
				window = {
					mappings = {
						["<BS>"] = "navigate_up",
						["."] = "set_root",
						["H"] = "toggle_hidden",
						["/"] = "fuzzy_finder",
						["D"] = "fuzzy_finder_directory",
						["f"] = "filter_on_submit",
					},
					fuzzy_finder_mappings = {
						["<C-n>"] = "move_cursor_down",
						["<C-p>"] = "move_cursor_up",
					},
				},
				git_status = {
					window = {
						position = "float",
						mappings = {
							["A"] = "git_add_all",
							["gu"] = "git_unstage_file",
							["ga"] = "git_add_file",
							["gr"] = "git_revert_file",
							["gc"] = "git_commit",
							["gp"] = "git_push",
							["gg"] = "git_commit_and_push",
						},
					},
				},
			},
		},
	},
	{
		"stevearc/dressing.nvim",
		event = { "VeryLazy" },
		opts = {},
	},
}
