return {
	"https://github.com/lewis6991/gitsigns.nvim",
	config = function()
		require("gitsigns").setup({
			signcolumn = true,
			numhl = false,
			attach_to_untracked = true,
			current_line_blame = true,
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol",
				delay = 500,
			},
		})
	end,
	init = function()
		if vim.fn.isdirectory(".git") ~= 0 then
			require("lazy").load({ plugins = "gitsigns.nvim" })
		end
	end,
}
