return {
	"akinsho/bufferline.nvim",
  event = { "UiEnter" },
  cond = not is_vscode(),
	config = function()
		require("bufferline").setup({
			options = {
				separator_style = "slant",
				always_show_bufferline = false,
				show_buffer_close_icons = false,
				show_close_icon = false,
				color_icons = true,
			},
		})
	end,
}
