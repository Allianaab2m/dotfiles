return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = {
		"mason.nvim",
		{ "williamboman/mason-lspconfig.nvim", config = function() end },
	},
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
					settins = {
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

		local servers = opts.servers
		local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			has_cmp and cmp_nvim_lsp.default_capabilities() or {},
			opts.capabilities or {}
		)

		local function setup(server)
			local server_opts = vim.tbl_deep_extend("force", {
				capabilities = vim.deepcopy(capabilities),
			}, servers[server] or {})
			if server_opts.enabled == false then
				return
			end

			if opts.setup[server] then
				if opts.setup[server](server, server_opts) then
					return
				end
			elseif opts.setup["*"] then
				if opts.setup["*"](server, server_opts) then
					return
				end
			end
			require("lspconfig")[server].setup(server_opts)
		end

		local have_mason, mlsp = pcall(require, "mason-lspconfig")
		local all_mlsp_servers = {}
		if have_mason then
			all_mlsp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
		end

		local ensure_installed = {}
		for server, server_opts in pairs(servers) do
			if server_opts then
				server_opts = server_opts == true and {} or server_opts
				if server_opts.enabled ~= false then
					if server_opts.mason == false or not vim.tbl_contains(all_mlsp_servers, server) then
						setup(server)
					else
						ensure_installed[#ensure_installed + 1] = server
					end
				end
			end
		end

		if have_mason then
			mlsp.setup({
				ensure_installed = vim.tbl_deep_extend(
					"force",
					ensure_installed,
					require("utils").opts("mason-lspconfig.nvim").ensure_installed or {}
				),
				handlers = { setup },
			})
		end
	end,
}
