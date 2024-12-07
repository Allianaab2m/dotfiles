local conditions = {
	buffer_not_empty = function()
		return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
	end,
	hide_in_width = function()
		return vim.fn.winwidth(0) > 80
	end,
	check_git_workspace = function()
		local filepath = vim.fn.expand("%:p:h")
		local gitdir = vim.fn.finddir(".git", filepath .. ";")
		return gitdir and #gitdir > 0 and #gitdir < #filepath
	end,
}

local components = {
	mode = function()
		local mode_state = vim.api.nvim_get_mode().mode
		if mode_state == ("i" or "ic" or "ix") then
			return require("utils").icons.mode.insert
		elseif mode_state == ("v" or "vs" or "V" or "Vs") then
			return require("utils").icons.mode.visual
		elseif mode_state == "t" then
			return require("utils").icons.mode.terminal
		else
			return require("utils").icons.vim
		end
	end,

	lsp = function()
		local msg = "Inactive"
		local buf_ft = vim.bo.filetype
		local clients = vim.lsp.get_clients({ bufnr = 0 })
		if next(clients) == nil then
			return msg
		end

		local lsp_names = {}
		for _, client in ipairs(clients) do
			local filetypes = client.config.filetypes
			if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
				table.insert(lsp_names, client.name)
			end
		end

		return "Active" .. "(" .. table.concat(lsp_names, ",") .. ")"
	end,
}

local palette = function()
	if require("utils").has("obscure") then
		return require("obscure.palettes").get_palette("obscure")
	elseif require("utils").has("catppuccin") then
		return require("catppuccin.palettes").get_palette("mocha")
	else
		return {
			bg = "#202328",
			fg = "#bbc2cf",
			yellow = "#ECBE7B",
			cyan = "#008080",
			darkblue = "#081633",
			green = "#98be65",
			orange = "#FF8800",
			violet = "#a9a1e1",
			magenta = "#c678dd",
			blue = "#51afef",
			red = "#ec5f67",
		}
	end
end

return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	init = function()
		vim.g.lualine_laststatus = vim.o.laststatus
		if vim.fn.argc(-1) > 0 then
			vim.o.statusline = " "
		else
			vim.o.laststatus = 0
		end
	end,
	config = function()
		local lualine = require("lualine")

		local icons = require("utils").icons

		local colors = palette()

		local config = {
			options = {
				component_separators = "",
				section_separators = "",
				theme = "auto",
			},
			sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_y = {},
				lualine_z = {},
				lualine_c = {},
				lualine_x = {},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_y = {},
				lualine_z = {},
				lualine_c = {},
				lualine_x = {},
			},
			extensions = { "neo-tree", "lazy" },
		}

		local ins_left = function(component)
			table.insert(config.sections.lualine_c, component)
		end

		local ins_right = function(component)
			table.insert(config.sections.lualine_x, component)
		end

		ins_left({
			components.mode,
			padding = { left = 2, right = 2 },
			color = function()
				local mode_color = {
					n = colors.red,
					i = colors.blue,
					v = colors.blue,
					V = colors.blue,
					c = colors.magenta,
					no = colors.red,
					s = colors.orange,
					S = colors.orange,
					ic = colors.yellow,
					R = colors.violet,
					Rv = colors.violet,
					cv = colors.red,
					ce = colors.red,
					r = colors.cyan,
					rm = colors.cyan,
					["r?"] = colors.cyan,
					["!"] = colors.red,
					t = colors.blue,
				}

				return { fg = mode_color[vim.api.nvim_get_mode().mode] }
			end,
		})

		ins_left({
			"filetype",
			icon_only = true,
			color = { fg = colors.magenta },
		})

		ins_left({
			"filename",
			cond = conditions.buffer_not_empty,
			symbols = icons.symbols,
			color = { fg = colors.violet },
		})

		ins_left({
			"branch",
			icon = "",
			color = { fg = colors.violet },
		})

		ins_left({
			"diff",
			symbols = icons.git,
			cond = conditions.hide_in_width,
			diff_color = {
				added = { fg = colors.green },
				modified = { fg = colors.orange },
				removed = { fg = colors.red },
			},
		})

		ins_left({
			"searchcount",
			icon = " ",
		})

		ins_left({
			"diagnostics",
			sources = { "nvim_diagnostic" },
			symbols = {
				error = icons.diagnostics.Error,
				warn = icons.diagnostics.Warn,
				info = icons.diagnostics.Info,
			},
			diagnostics_color = {
				color_error = { fg = colors.red },
				color_warn = { fg = colors.yellow },
				color_info = { fg = colors.cyan },
			},
		})

		ins_right({
			components.lsp,
			icon = " ",
			color = { fg = colors.orange },
		})

		ins_left({
			function()
				return "%="
			end,
		})

		ins_right({
			"o:encoding",
			fmt = string.upper,
			cond = conditions.hide_in_width,
			color = { fg = colors.green },
		})

		ins_right({
			"location",
			color = { fg = colors.green },
		})

		ins_right({
			"progress",
			color = { fg = colors.fg },
		})

		lualine.setup(config)
	end,
}
