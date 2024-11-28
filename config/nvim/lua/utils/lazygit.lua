---@class LazyGit
---@field config_dir? string
---@overload fun(cmd: string|string[], opts: TermOpts): LazyFloat
local M = setmetatable({}, {
	__call = function(m, ...)
		return m.open(...)
	end,
})

---@alias LazyGitColor {fg?: string, bg?: string, bold?: boolean}

---@class LazyGitTheme: table<number, LazyGitColor>
---@field activeBorderColor LazyGitColor
---@field cherryPickedCommitBgColor LazyGitColor
---@field cherryPickedCommitFgColor LazyGitColor
---@field defaultFgColor LazyGitColor
---@field inactiveBorderColor LazyGitColor
---@field optionsTextColor LazyGitColor
---@field searchingActiveBorderColor LazyGitColor
---@field selectedLineBgColor LazyGitColor
---@field unstagedChangesColor LazyGitColor
M.theme = {
	[241] = { fg = "Special" },
	activeBorderColor = { fg = "MatchParen", bold = true },
	cherryPickedCommitBgColor = { fg = "Identifier" },
	cherryPickedCommitFgColor = { fg = "Function" },
	defaultFgColor = { fg = "Normal" },
	inactiveBorderColor = { fg = "FloatBorder" },
	optionsTextColor = { fg = "Function" },
	searchingActiveBorderColor = { fg = "MatchParen", bold = true },
	selectedLineBgColor = { bg = "Visual" }, -- set to `default` to have no background colour
	unstagedChangesColor = { fg = "DiagnosticError" },
}

M.theme_path = require("utils").norm(vim.fn.stdpath("cache") .. "/lazygit-theme.yml")

M.dirty = true

vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		M.dirty = true
	end,
})

---@param opts? TermOpts | {args?: string[]}
M.open = function(opts)
	opts = vim.tbl_deep_extend("force", {}, {
		esc_esc = false,
		ctrl_hjkl = false,
	}, opts or {})

	local cmd = { "lazygit" }
	vim.list_extend(cmd, opts.args or {})

	return require("utils.term")(cmd, opts)
end

return M
