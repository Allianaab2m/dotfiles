require("dap").adapters.codelldb = {
	type = "server",
	port = "${port}",
	executable = {
		command = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb",
		args = { "--port", "${port}" },
	},
}

require("dap").configurations = {
	cpp = {
		name = "Launch file",
		type = "codelldb",
		request = "launch",

		cwd = "${workspaceFolder}",
		stopOnEntry = false,
	},
}
