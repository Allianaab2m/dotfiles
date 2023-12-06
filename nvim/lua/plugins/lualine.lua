local function lualine_lspnames()
	local clients = {}
	for _, client in ipairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
		table.insert(clients, client.name)
	end
	return " " .. table.concat(clients, ", ")
end

return {
	"https://github.com/nvim-lualine/lualine.nvim",
	enabled = false,
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
}
