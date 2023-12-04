local function myMiniView(pattern, kind)
	kind = kind or ""
	return {
		view = "mini",
		filter = {
			event = "msg_show",
			kind = kind,
			find = pattern,
		},
	}
end

return {
	"https://github.com/folke/noice.nvim",
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
		messages = {
			view_search = "mini",
		},
		routes = {
			{
				view = "notify",
				filter = { event = "msg_showmode" },
			},
			{
				filter = {
					event = "notify",
					warning = true,
					find = "failed to run generator.*us not executable",
				},
				opts = { skip = true },
			},
			myMiniView("Already at .* change"),
			myMiniView("written"),
			myMiniView("yanked"),
			myMiniView("more lines?"),
			myMiniView("fewer lines?"),
			myMiniView("fewer lines?", "lua_error"),
			myMiniView("change; before"),
			myMiniView("change; after"),
			myMiniView("line less"),
			myMiniView("lines indented"),
			myMiniView("lines >ed"),
			myMiniView("lines <ed"),
			myMiniView("No lines in buffer"),
			myMiniView("search hit .*, continuing at", "wmsg"),
			myMiniView("E486: Pattern not found", "emsg"),
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
}
