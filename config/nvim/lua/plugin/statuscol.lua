return {
	"luukvbaal/statuscol.nvim",
	event = "VeryLazy",
	config = function()
		local builtin = require("statuscol.builtin")
		require("statuscol").setup({
			bt_ignore = { "terminal", "nofile", "ddu-ff", "ddu-ff-filter" },
			relculright = true,
			segments = {
				{
					sign = {
						namespace = { "diagnostic" },
						maxwidth = 1,
						colwidth = 2,
					},
				},
				{
					sign = {
						namespace = { "MiniDiffViz" },
						maxwidth = 1,
						colwidth = 1,
						wrap = true,
					},
				},
				-- {
				-- 	sign = {
				-- 		namespace = { ".*" },
				-- 	},
				-- },
				{
					text = { builtin.lnumfunc },
				},
				{ text = { "│" } },
			},
		})
	end,
}
