return {
	"rcarriga/nvim-notify",
	lazy = false,
	keys = {
		{
			"<leader>un",
			function()
				require("notify").dismiss({
					silent = true,
					pending = true,
				})
			end,
			desc = "Dismiss all notifications",
		},
	},
	opts = {
		stages = "fade",
		timeout = 2000,
		max_height = require("utils").lines_percent(0.75),
		max_width = require("utils").columns_percent(0.75),
		on_open = function(win)
			vim.api.nvim_win_set_config(win, { zindex = 100 })
		end,
	},
	init = function()
		vim.notify = require("notify")
	end,
}
