if not vim.g.vscode then
	return {}
end

local enabled = {
	"flit.nvim",
	"lazy.nvim",
	"leap.nvim",
	"mini.ai",
	"mini.comment",
	"mini.move",
	"mini.pairs",
	"mini.surround",
	"nvim-treesitter",
	"nvim-treesitter-textobjects",
	"nvim-ts-context-commentstring",
	"ts-comments.nvim",
	"vim-repeat",
	"yanky.nvim",
	"clever-f.vim",
	"quick-scope",
}

local Config = require("lazy.core.config")
Config.options.checker.enabled = false
Config.options.change_detection.enabled = false
Config.options.defaults.cond = function(plugin)
	return vim.tbl_contains(enabled, plugin.name) or plugin.vscode
end

return {
	"nvim-treesitter/nvim-treesitter",
	opts = { highlight = { enable = false } },
}
