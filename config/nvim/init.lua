require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.lazy")
if not vim.g.vscode then
	require("config.lsp")
end
