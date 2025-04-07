local M = {}

local map = vim.keymap.set

vim.g.mapleader = " "

map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

map("i", "jj", "<Esc>", { desc = "Esc" })
map("i", "JJ", "<Esc>", { desc = "Esc" })
map("i", "jk", "<Esc>", { desc = "Esc" })
map("i", "JK", "<Esc>", { desc = "Esc" })
map("i", "kj", "<Esc>", { desc = "Esc" })
map("i", "KJ", "<Esc>", { desc = "Esc" })

map("n", "<S-h>", "<Cmd>bprev<CR>", { desc = "Prev buffer" })
map("n", "<S-l>", "<Cmd>bprev<CR>", { desc = "Prev buffer" })

map("n", "<leader>gg", function()
	require("utils.lazygit")({ cwd = require("utils.root").git() })
end, { desc = "Lazygit (Root Dir)" })
map("n", "<leader>gG", function()
	require("utils.lazygit")()
end, { desc = "Lazygit (cwd)" })
-- map("n", "<leader>gb", LazyVim.lazygit.blame_line, { desc = "Git Blame Line" })
-- map("n", "<leader>gB", LazyVim.lazygit.browse, { desc = "Git Browse" })
map("n", "<leader>gf", function()
	local git_path = vim.api.nvim_buf_get_name(0)
	require("utils.lazygit")({ args = { "-f", vim.trim(git_path) } })
end, { desc = "Lazygit current file history" })
map("n", "<leader>gl", function()
	require("utils.lazygit")({ args = { "log" }, cwd = require("utils.root").git() })
end, { desc = "Lazygit log" })
map("n", "<leader>gL", function()
	require("utils.lazygit")({ args = { "log" } })
end, { desc = "Lazygit log (cwd)" })

map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

map("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
map("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })

-- floating terminal
local term = function()
	require("utils.term")(nil, { cwd = require("utils.root")() })
end
map("n", "<leader>ft", term, { desc = "Terminal (Root Dir)" })
map("n", "<leader>fT", function()
	require("utils.term")()
end, { desc = "Terminal (cwd)" })
map("n", "<c-/>", term, { desc = "Terminal (Root Dir)" })
map("n", "<c-_>", term, { desc = "which_key_ignore" })

-- Terminal Mappings
map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
map("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to Left Window" })
map("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to Lower Window" })
map("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to Upper Window" })
map("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to Right Window" })
map("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
map("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })

-- windows
map("n", "<leader>w", "<c-w>", { desc = "Windows", remap = true })
map("n", "<leader>-", "<C-W>s", { desc = "Split Window Below", remap = true })
map("n", "<leader>|", "<C-W>v", { desc = "Split Window Right", remap = true })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete Window", remap = true })

M.lsp = {
	{ "<leader>li", "<cmd>LspInfo<cr>", desc = "Lsp Info" },
	{ "gd", vim.lsp.buf.definition, desc = "Goto Definition", has = "definition" },
	{ "gr", vim.lsp.buf.references, desc = "References", nowait = true },
	{ "gI", vim.lsp.buf.implementation, desc = "Goto Implementation" },
	{ "gy", vim.lsp.buf.type_definition, desc = "Goto T[y]pe Definition" },
	{ "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
	{ "K", vim.lsp.buf.hover, desc = "Hover" },
	{ "gK", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" },
	{
		"<c-k>",
		vim.lsp.buf.signature_help,
		mode = "i",
		desc = "Signature Help",
		has = "signatureHelp",
	},
	{
		"<leader>la",
		vim.lsp.buf.code_action,
		desc = "Code Action",
		mode = { "n", "v" },
		has = "codeAction",
	},
	{
		"<leader>lc",
		vim.lsp.codelens.run,
		desc = "Run Codelens",
		mode = { "n", "v" },
		has = "codeLens",
	},
	{
		"<leader>lC",
		vim.lsp.codelens.refresh,
		desc = "Refresh & Display Codelens",
		mode = { "n" },
		has = "codeLens",
	},
	-- {
	-- 	"<leader>cR",
	-- 	require("utils.lsp").rename_file,
	-- 	desc = "Rename File",
	-- 	mode = { "n" },
	-- 	has = { "workspace/didRenameFiles", "workspace/willRenameFiles" },
	-- },
	{
		"<leader>lr",
		function()
			local inc_rename = require("inc_rename")
			return ":" .. inc_rename.config.cmd_name .. " " .. vim.fn.expand("<cword>")
		end,
		expr = true,
		desc = "Rename",
		has = "rename",
	},
	-- { "<leader>cA", require("utils.lsp").action.source, desc = "Source Action", has = "codeAction" },
}

---@param method string|string[]
M.has = function(buffer, method)
	if type(method) == "table" then
		for _, m in ipairs(method) do
			if M.has(buffer, m) then
				return true
			end
		end
		return false
	end
	method = method:find("/") and method or "textDocument/" .. method
	local clients = require("utils.lsp").get_clients({ bufnr = buffer })
	for _, client in ipairs(clients) do
		if client.supports_method(method) then
			return true
		end
	end
	return false
end

M.on_attach = function(_, buffer)
	local Keys = require("lazy.core.handler.keys")
	for _, keys in pairs(M.lsp) do
		local has = not keys.has or M.has(buffer, keys.has)
		local cond = not (keys.cond == false or ((type(keys.cond) == "function") and not keys.cond()))

		if has and cond then
			local opts = Keys.opts(keys)
			opts.cond = nil
			opts.has = nil
			opts.silent = opts.silent ~= false
			opts.buffer = buffer
			vim.keymap.set(keys.mode or "n", keys[1], keys[2], opts)
		end
	end
end

return M
