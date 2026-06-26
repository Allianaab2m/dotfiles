vim.diagnostic.config({
	virtual_text = true,
})

local augroup = vim.api.nvim_create_augroup("lsp/init.lua", {})

vim.api.nvim_create_autocmd("LspAttach", {
	group = augroup,
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
	end,
})

vim.lsp.config("*", {
	root_markers = { ".git" },
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)

		if not client then
			return
		end

		if client.name == "biome" then
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = vim.api.nvim_create_augroup("BiomeFixAll", { clear = true }),
				callback = function()
					vim.lsp.buf.code_action({
						context = {
							only = { "source.fixAll.biome" },
							diagnostics = {},
						},
						apply = true,
					})
				end,
			})
		end
	end,
})

vim.lsp.enable({
	"lua_ls",
	"vtsls",
	"biome",
	"gopls",
	"gleam",
	"ruby_lsp",
})
