local dirname = vim.fn.stdpath("config") .. "/lua/config/lsp"

local lsp_names = {}

vim.lsp.config("*", {
	capabilities = require("blink.cmp").get_lsp_capabilities(),
})

vim.diagnostic.config({
	underline = true,
	update_in_insert = false,
	virtual_text = false,
	virtual_lines = {
		current_line = true,
		format = function(diag)
			if diag.code then
				return string.format("%s: [%s](%s)", diag.message, diag.source, diag.code)
			else
				return string.format("%s: [%s]", diag.message, diag.source)
			end
		end,
	},
	severity_sort = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = require("utils").icons.diagnostics.Error,
			[vim.diagnostic.severity.WARN] = require("utils").icons.diagnostics.Warn,
			[vim.diagnostic.severity.HINT] = require("utils").icons.diagnostics.Hint,
			[vim.diagnostic.severity.INFO] = require("utils").icons.diagnostics.Info,
		},
	},
	float = {
		border = "single",
		title = "Diagnostics",
		header = {},
		suffix = {},
		format = function(diag)
			if diag.code then
				return string.format("[%s](%s): %s", diag.source, diag.code, diag.message)
			else
				return string.format("[%s]: %s", diag.source, diag.message)
			end
		end,
	},
})

for file, ftype in vim.fs.dir(dirname) do
	if ftype == "file" and vim.endswith(file, ".lua") and file ~= "init.lua" then
		local lsp_name = file:sub(1, -5)
		local ok, res = pcall(require, "config.lsp." .. lsp_name)
		if ok then
			vim.lsp.config(lsp_name, res)
			table.insert(lsp_names, lsp_name)
		else
			vim.notify("Error loading LSP: " .. lsp_name .. "\n" .. res, vim.log.levels.WARN)
		end
	end
end

require("utils.lsp").on_attach(function(client, buffer)
	require("config.keymaps").on_attach(client, buffer)
end)

require("utils.lsp").on_attach(function(client, buffer)
	require("utils.lsp").on_supports_method("textDocument/inlayHint", function(client, buffer)
		if vim.api.nvim_buf_is_valid(buffer) and vim.bo[buffer].buftype == "" then
			vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
		end
	end)
end)

vim.lsp.enable(lsp_names)
