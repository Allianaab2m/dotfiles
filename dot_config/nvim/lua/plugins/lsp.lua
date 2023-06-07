return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "folke/neoconf.nvim", cmd = "Neoconf", config = true },
			{ "folke/neodev.nvim", opts = { experimental = { pathStrict = true } } },
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		opts = {
			diagnostics = {
				underline = true,
				virtual_text = {
					spacing = 4,
					source = "if_many",
					prefix = "icons",
				},
				severity_sort = true,
			},
			capabilities = {},
			autoformat = true,
			format = {
				formatting_options = nil,
				timeout_ms = nil,
			},
			servers = {
				jsonls = {},
				lua_ls = {
					settings = {
						Lua = {
							workspace = {
								checkThirdParty = false,
							},
							completion = {
								callSnippet = "Replace",
							},
						},
					},
				},
				tsserver = {
					settings = {
						typescript = {
							inlayHints = {
								includeInlayParameterNameHints = "all",
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = true,
								includeInlayVariableTypeHintsWhenTypeMatchesName = false,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
						},
					},
				},
			},
			setup = {},
		},
		config = function(_, opts)
			local Util = require("utils")
			require("utils.lsp").autoformat = opts.autoformat
			Util.on_attach(function(client, buffer)
				require("utils.lsp").format_on_attach(client, buffer)
				require("utils.lsp").keymaps_on_attach(client, buffer)
			end)

			for name, icon in pairs(Util.icons.diagnostics) do
				name = "DiagnosticSign" .. name
				vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
			end

			if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
				opts.diagnostics.virtual_text.prefix = vim.fn.has("nvim-0.10.0") == 0 and "●"
					or function(diagnostic)
						local icons = Util.icons.diagnostics
						for d, icon in pairs(icons) do
							if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
								return icon
							end
						end
					end
			end

			vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
				border = "single",
			})

			vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
				border = "single",
			})

			local servers = opts.servers
			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				--require("cmp_nvim_lsp").default_capabilities(),
				{},
				opts.capabilities or {}
			)

			local function setup(server)
				local server_opts = vim.tbl_deep_extend("force", {
					capabilities = vim.deepcopy(capabilities),
				}, servers[server] or {})

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

			local ensure_installed = {} ---@type string[]
			for server, server_opts in pairs(servers) do
				if server_opts then
					server_opts = server_opts == true and {} or server_opts
					if server_opts.mason == false or not vim.tbl_contains(all_mlsp_servers, server) then
						setup(server)
					else
						ensure_installed[#ensure_installed + 1] = server
					end
				end
			end

			if have_mason then
				mlsp.setup({ ensure_installed = ensure_installed })
				mlsp.setup_handlers({ setup })
			end

			if Util.lsp_get_config("denols") and Util.lsp_get_config("tsserver") then
				local is_deno = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc")
				Util.lsp_disable("tsserver", is_deno)
				Util.lsp_disable("denols", function(root_dir)
					return not is_deno(root_dir)
				end)
			end
		end,
	},
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		opts = {
			ensure_installed = {
				"stylua",
			},
		},
		config = function(_, opts)
			require("mason").setup(opts)
			local mr = require("mason-registry")
			local function ensure_installed()
				for _, tool in ipairs(opts.ensure_installed) do
					local p = mr.get_package(tool)
					if not p:is_installed() then
						p:install()
					end
				end
			end
			if mr.refresh then
				mr.refresh(ensure_installed)
			else
				ensure_installed()
			end
		end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "mason.nvim" },
		opts = function()
			local nls = require("null-ls")
			return {
				root_dir = require("null-ls.utils").root_pattern(
					".null-ls-root",
					".neoconf.json",
					"Makefile",
					".git",
					"package.json"
				),
				sources = {
					nls.builtins.formatting.stylua,
					nls.builtins.formatting.eslint_d,
					nls.builtins.formatting.prettier,
					nls.builtins.diagnostics.eslint_d,
					nls.builtins.diagnostics.textlint,
				},
			}
		end,
	},
	{
		"lvimuser/lsp-inlayhints.nvim",
		event = { "LspAttach" },
		opts = function()
			vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
			vim.api.nvim_create_autocmd("LspAttach", {
				group = "LspAttach_inlayhints",
				callback = function(args)
					if not (args.data and args.data.client_id) then
						return
					end

					local bufnr = args.buf
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					require("lsp-inlayhints").on_attach(client, bufnr)
				end,
			})
			return {}
		end,
	},
	{
		"SmiteshP/nvim-navic",
		event = { "LspAttach" },
		opts = function()
			vim.api.nvim_create_augroup("LspAttach_navic", {})
			vim.api.nvim_create_autocmd("LspAttach", {
				group = "LspAttach_navic",
				callback = function(args)
					if not (args.data and args.data.client_id) then
						return
					end

					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if client.server_capabilities.documentSymbolProvider then
						require("nvim-navic").attach(client, args.buf)
					end
				end,
			})
			return {}
		end,
	},
}
