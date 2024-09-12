local M = {}

---@param on_attach fun(client: vim.lsp.Client, buffer)
---@param name? string
M.on_attach = function(on_attach, name)
	return vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local buffer = args.buf ---@type number
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			if client and (not name or client.name == name) then
				return on_attach(client, buffer)
			end
		end,
	})
end

---@type table<string, table<vim.lsp.Client, table<number, boolean>>>
M._supports_method = {}

M.setup = function()
	local register_capability = vim.lsp.handlers["client/registerCapability"]
	vim.lsp.handlers["client/registerCapability"] = function(err, res, ctx)
		local ret = register_capability(err, res, ctx)
		local client = vim.lsp.get_client_by_id(ctx.client_id)
		if client then
			for buffer in pairs(client.attached_buffers) do
				vim.api.nvim_exec_autocmds("User", {
					pattern = "LspDynamicCapability",
					data = { client_id = client.id, buffer = buffer },
				})
			end
		end
		return ret
	end
	M.on_attach(M._check_methods)
	M.on_dynamic_capability(M._check_methods)
end

---@param client vim.lsp.Client
M._check_methods = function(client, buffer)
	if not vim.api.nvim_buf_is_valid(buffer) then
		return
	end

	if not vim.bo[buffer].buflisted then
		return
	end

	if vim.bo[buffer].buftype == "nofile" then
		return
	end

	for method, clients in pairs(M._supports_method) do
		clients[client] = clients[client] or {}
		if not clients[client][buffer] then
			if client.supports_method and client.supports_method(method, { bufnr = buffer }) then
				clients[client][buffer] = true
				vim.api.nvim_exec_autocmds("user", {
					pattern = "LspSupportsMethod",
					data = { client_id = client.id, buffer = buffer, method = method },
				})
			end
		end
	end
end

---@param fn fun(client: vim.lsp.Client, buffer): boolean?
---@param opts? {group?: integer}
M.on_dynamic_capability = function(fn, opts)
	return vim.api.nvim_create_autocmd("User", {
		pattern = "LspDynamicCapability",
		group = opts and opts.group or nil,
		callback = function(args)
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			local buffer = args.data.buffer ---@type number
			if client then
				return fn(client, buffer)
			end
		end,
	})
end

---@param method string
---@param fn fun(client: vim.lsp.Client, buffer)
M.on_supports_method = function(method, fn)
	M._supports_method[method] = M._supports_method[method] or setmetatable({}, { _mode = "k" })
	return vim.api.nvim_create_autocmd("User", {
		pattern = "LspSupportsMethod",
		callback = function(args)
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			local buffer = args.data.buffer ---@type number
			if client and method == args.data.method then
				return fn(client, buffer)
			end
		end,
	})
end

---@alias lspFilter {id?: number, bufnr?: number, name?: string, method?: string, filter?: fun(client: vim.lsp.Client):boolean}
---@alias lsp.Clientformat {timeout_ms?: number, format_options?: table} | lspFilter

---@param opts? lspFilter
M.get_clients = function(opts)
	local ret = {} ---@type vim.lsp.Client[]
	if vim.lsp.get_clients(opts) then
		ret = vim.lsp.get_clients(opts)
	else
		---@diagnostic disable-next-line: deprecated
		ret = vim.lsp.get_active_clients(opts)
		if opts and opts.method then
			---@param client vim.lsp.Client
			ret = vim.tbl_filter(function(client)
				return client.supports_method(opts.method, { bufnr = opts.bufnr })
			end, ret)
		end
	end
	return opts and opts.filter and vim.tbl_filter(opts.filter, ret) or ret
end

---@param from string
---@param to string
---@param rename? fun()
M.on_rename = function(from, to, rename)
	local changes = {
		files = {
			{
				oldUri = vim.uri_from_fname(from),
				newUri = vim.uri_from_fname(to),
			},
		},
	}

	local clients = M.get_clients()
	for _, client in ipairs(clients) do
		if client.supports_method("workspace/willRenameFiles") then
			local resp = client.request_sync("workspace/willRenameFiles", changes, 1000, 0)
			if resp and resp.result ~= nil then
				vim.lsp.util.apply_workspace_edit(resp.result, client.offset_encoding)
			end
		end
	end

	if rename then
		rename()
	end

	for _, client in ipairs(clients) do
		if client.supports_method("workspace/didRenameFiles") then
			client.notify("workspace/didRenameFiles", changes)
		end
	end
end

---@param opts? Formatter | {filter?: (string|lspFilter)}
M.formatter = function(opts)
	opts = opts or {}
	local filter = opts.filter or {}
	filter = type(filter) == "string" and { name = filter } or filter
	---@cast filter lspFilter
	---@type Formatter
	local ret = {
		name = "LSP",
		primary = true,
		priority = 1,
		format = function(buf)
			M.format(require("utils").merge({}, filter, { bufnr = buf }))
		end,
		sources = function(buf)
			local clients = M.get_clients(require("utils").merge({}, filter, { bufnr = buf }))
			---@param client vim.lsp.Client
			local ret = vim.tbl_filter(function(client)
				return client.supports_method("textDocument/formatting")
					or client.supports_method("textDocument/rangeFormatting")
			end, clients)
			---@param client vim.lsp.Client
			return vim.tbl_map(function(client)
				return client.name
			end, ret)
		end,
	}
	return require("utils").merge(ret, opts)
end

---@param opts? lsp.Clientformat
M.format = function(opts)
	opts = vim.tbl_deep_extend(
		"force",
		{},
		opts or {},
		require("utils").opts("nvim-lspconfig").format or {},
		require("utils").opts("conform.nvim").format or {}
	)
	local ok, conform = pcall(require, "conform")
	if ok then
		opts.formatters = {}
		conform.format(opts)
	else
		vim.lsp.buf.format(opts)
	end
end

M.action = setmetatable({}, {
	__index = function(_, action)
		return function()
			vim.lsp.buf.code_action({
				apply = true,
				context = {
					only = { action },
					diagnostics = {},
				},
			})
		end
	end,
})

---@class LspCommand: lsp.ExecuteCommandParams
---@field open? boolean
---@field handler? lsp.Handler

---@param opts LspCommand
M.execute = function(opts)
	local params = {
		command = opts.command,
		arguments = opts.arguments,
	}
	if opts.open then
		require("trouble").open({
			mode = "lsp_command",
			params = params,
		})
	else
		return vim.lsp.buf_request(0, "workspace/executeCommand", params, opts.handler)
	end
end

return M
