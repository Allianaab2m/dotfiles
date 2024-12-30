return {
	"nvim-flutter/flutter-tools.nvim",
	lazy = false,
	cond = function()
		local git_root = vim.fs.root(0, ".git")
		if not git_root then
			return false
		end
		if vim.uv.fs_stat(git_root .. "/pubspec.yaml") then
			return true
		end
		return false
	end,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"stevearc/dressing.nvim",
	},
	config = true,
}
