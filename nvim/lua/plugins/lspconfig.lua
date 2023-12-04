local icons = require("utils").icons.diagnostics
local on_attach = require("utils").on_attach

-- Keybinds
on_attach(function(client, bufnr)
	local opts = { noremap = true, silent = true }
	local keymap = vim.api.nvim_buf_set_keymap
	keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	keymap(bufnr, "n", "gl", "<cmd>lua vim.lsp.diagnostic.open_float()<CR>", opts)
	--keymap(bufnr, "n", "<leader>lf", "<cmd>lua vim.lsp.buf.format { async = true }<CR>", opts)
	keymap(bufnr, "n", "<leader>li", "<cmd>LspInfo<CR>", opts)
	keymap(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	keymap(bufnr, "n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer = 0, float = false})<CR>", opts)
	keymap(bufnr, "n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer = 0, float = false})<CR>", opts)
	keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	keymap(bufnr, "n", "<leader>lq", "<cmd>TroubleToggle document_diagnostics<CR>", opts)
end)

return {
	"https://github.com/neovim/nvim-lspconfig",
	event = { "BufReadPost", "BufNewFile", "BufWritePre" },
	dependencies = {
		--{ "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
		{ "https://github.com/folke/neodev.nvim", opts = {} },
		{ "https://github.com/williamboman/mason.nvim" },
		"https://github.com/williamboman/mason-lspconfig.nvim",
	},
	opts = {
		diagnostics = {
			underline = true,
			update_in_insert = false,
			virtual_text = {
				spacing = 4,
				source = "if_many",
				prefix = "icons",
				format = function(diagnostic)
					return string.format("%s (%s: %s)", diagnostic.message, diagnostic.source, diagnostic.code)
				end,
			},
			severity_sort = true,
		},
		inlay_hints = {
			enabled = false,
		},
		capabilities = {},
	},
	config = function(_, opts)
		require("mason").setup()
		require("mason-lspconfig").setup()
		--require("neoconf.nvim").setup()

		for name, icon in pairs(icons) do
			name = "DiagnosticSign" .. name
			vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
		end

		-- Add icons to Diagnostic virtual text
		if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
			opts.diagnostics.virtual_text.prefix = vim.fn.has("nvim-0.10.0") == 0 and "●"
				or function(diagnostic)
					for d, icon in pairs(icons) do
						if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
							return icon
						end
					end
				end
		end

		vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

		require("mason-lspconfig").setup_handlers({
			function(server_name)
				require("lspconfig")[server_name].setup({})
			end,
			["rust_analyzer"] = function()
				require("rust-tools").setup({})
			end,
			["lua_ls"] = function()
				local lspconfig = require("lspconfig")
				lspconfig.lua_ls.setup({
					settings = {
						Lua = {
							workspace = {
								checkThirdParty = false,
							},
						},
					},
				})
			end,
		})
	end,
}
