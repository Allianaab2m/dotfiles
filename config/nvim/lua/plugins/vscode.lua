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

vim.cmd([[
  highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
  highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
]])

vim.api.nvim_set_keymap("n", "j", "gj", { noremap = false, silent = true })
vim.api.nvim_set_keymap("n", "k", "gk", { noremap = false, silent = true })

local vscode = require("vscode")

local function map(mode, lhs, rhs)
	vim.keymap.set(mode, lhs, function()
		vscode.call(rhs)
	end, { silent = true, noremap = true })
end

-- Remap folding keys
map("n", "zM", "editor.foldAll")
map("n", "zR", "editor.unfoldAll")
map("n", "zc", "editor.fold")
map("n", "zC", "editor.foldRecursively")
map("n", "zo", "editor.unfold")
map("n", "zO", "editor.unfoldRecursively")
map("n", "za", "editor.toggleFold")

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
