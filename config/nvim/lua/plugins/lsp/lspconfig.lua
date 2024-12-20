return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPost", "BufNewFile" },
	opts = function()
		---@class PluginLspOpts
		local ret = {
			---@type vim.diagnostic.Opts
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
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = require("utils").icons.diagnostics.Error,
						[vim.diagnostic.severity.WARN] = require("utils").icons.diagnostics.Warn,
						[vim.diagnostic.severity.HINT] = require("utils").icons.diagnostics.Hint,
						[vim.diagnostic.severity.INFO] = require("utils").icons.diagnostics.Info,
					},
				},
			},
			inlay_hints = {
				enabled = true,
				exclude = {},
			},
			codelens = {
				enabled = true,
			},
			document_highlight = {
				enabled = true,
			},
			capabilities = {
				workspace = {
					fileOperations = {
						didRename = true,
						willRename = true,
					},
				},
			},
			format = {
				formatting_options = nil,
				timeout_ms = nil,
			},
			servers = {
				lua_ls = {
					settings = {
						Lua = {
							workspace = {
								checkThirdParty = false,
							},
							codeLens = {
								enable = true,
							},
							completion = {
								callSnippet = "Replace",
							},
							doc = {
								privateName = { "^_" },
							},
							hint = {
								enable = true,
								setType = false,
								paramType = true,
								paramName = "Disable",
								semicolon = "Disable",
								arrayIndex = "Disable",
							},
						},
					},
				},
			},
			setup = {},
		}
		return ret
	end,
	---@param opts PluginLspOpts
	config = function(_, opts)
		require("utils.lsp").on_attach(function(client, buffer)
			require("config.keymaps").on_attach(client, buffer)
		end)
		require("utils.lsp").setup()

		local servers = {
			--"nil",
			"hls",
			"lua_ls",
			"vtsls",
			"pyright",
			"nil_ls",
		}

		-- diagnostics signs
		for severity, icon in pairs(opts.diagnostics.signs.text) do
			local name = vim.diagnostic.severity[severity]:lower():gsub("^%l", string.upper)
			name = "DiagnosticSign" .. name
			vim.fn.sign_define(name, { text = icon, tethl = name, numhl = "" })
		end

		if opts.inlay_hints.enabled then
			require("utils.lsp").on_supports_method("textDocument/inlayHint", function(client, buffer)
				if
					vim.api.nvim_buf_is_valid(buffer)
					and vim.bo[buffer].buftype == ""
					and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[buffer].filetype)
				then
					vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
				end
			end)
		end

		if opts.codelens.enabled and vim.lsp.codelens then
			require("utils.lsp").on_supports_method("textDocument/codeLens", function(client, buffer)
				vim.lsp.codelens.refresh()
				vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
					buffer = buffer,
					callback = vim.lsp.codelens.refresh,
				})
			end)
		end

		opts.diagnostics.virtual_text.prefix = function(diagnostic)
			local icons = require("utils").icons.diagnostics
			for d, icon in pairs(icons) do
				if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
					return icon
				end
			end
		end

		vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

		local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			has_cmp and cmp_nvim_lsp.default_capabilities() or {},
			opts.capabilities or {}
		)

		local setup_handler = function(server_name)
			local ls_specific = opts.servers[server_name]
			if server_name == "lua_ls" and ls_specific then
				require("lspconfig")["lua_ls"].setup(vim.tbl_deep_extend("force", capabilities, ls_specific))
			end

			require("lspconfig")[server_name].setup(vim.tbl_deep_extend("force", capabilities, opts))
		end

		for _, server in ipairs(servers) do
			setup_handler(server)
		end
	end,
}
