local diagnostic = function(_client, _bufnr)
	vim.diagnostic.config({
		underline = true,
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = " ",
				[vim.diagnostic.severity.WARN] = " ",
				[vim.diagnostic.severity.INFO] = " ",
				[vim.diagnostic.severity.HINT] = " ",
			},
		},
		update_in_insert = false,
		severity_sort = true,
		float = {
			sformat = function(diagnostic)
				return string.format("[%s] %s (%s)", diagnostic.message, diagnostic.source, diagnostic.code)
			end,
		},
	})
end

local keybind = function(client, bufnr)
	for _, key in ipairs({ "gra", "gri", "grn", "grr", "grt" }) do
		pcall(vim.keymap.del, "n", key)
	end

	local function keyset(mode, lhs, rhs, opts)
		local maparg = vim.fn.maparg

		if type(mode) == "table" then
			for _, m in ipairs(mode) do
				keyset(m, lhs, rhs, opts)
			end
			return
		end

		local function is_nop(_lhs, _mode)
			local keymap = maparg(_lhs, _mode)
			return (keymap == "" or keymap:lower() == "<nop>")
		end

		if is_nop(lhs, mode) then
			vim.keymap.set(mode, lhs, rhs, opts)
		end
	end

	local function opts(desc)
		return { silent = true, buffer = bufnr, desc = desc }
	end

	keyset("n", "K", vim.lsp.buf.hover, opts("hover doc"))

	keyset("n", "cr", vim.lsp.buf.rename, opts("lsp rename"))

	keyset("n", "ca", require("tiny-code-action").code_action, opts("lsp code action"))

	keyset("n", "gd", Snacks.picker.lsp_definitions, opts("lsp definitions"))
	keyset("n", "gD", Snacks.picker.lsp_declarations, opts("lsp declarations"))
	keyset("n", "gr", Snacks.picker.lsp_references, opts("lsp references"))
	keyset("n", "gI", Snacks.picker.lsp_implementations, opts("lsp implementations"))
	keyset("n", "gt", Snacks.picker.lsp_type_definitions, opts("lsp type definitions"))
end

return {
	"neovim/nvim-lspconfig",
	lazy = false,
	cond = not is_vscode(),
	init = function()
		require("core.plugin").on_attach(function(client, bufnr)
			local exclude_ft = { "oil" }
			local ft = vim.bo.filetype

			if vim.tbl_contains(exclude_ft, ft) then
				return
			end

			local on_attach = function(c, b)
				diagnostic(c, b)
				keybind(c, b)
			end

			on_attach(client, bufnr)

			vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

			vim.api.nvim_create_user_command("LspDiagnosticReset", function()
				vim.diagnostic.reset()
			end, {})
		end)
	end,
}
