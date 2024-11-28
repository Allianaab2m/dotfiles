return {
	"williamboman/mason.nvim",
	cmd = "Mason",
	keys = {
		{ "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" },
		{
			"<leader>db",
			function()
				require("dap").list_breakpoints()
			end,
			desc = "DAP Breakpoints",
		},
		{
			"<F1>",
			function()
				require("dap.ui.widgets").hover(nil, { border = "rounded" })
			end,
			desc = "DAP Hover",
		},
		{ "<F4>", "<CMD>DapTerminate<CR>", desc = "DAP Terminate" },
		{ "<F5>", "<CMD>DapContinue<CR>", desc = "DAP Continue" },
		{
			"<F6>",
			function()
				require("dap").run_to_cursor()
			end,
			desc = "Run to Cursor",
		},
		{ "<F9>", "<CMD>DapToggleBreakpoint<CR>", desc = "Toggle Breakpoint" },
		{ "<F10>", "<CMD>DapStepOver<CR>", desc = "Step Over" },
		{ "<F11>", "<CMD>DapStepInto<CR>", desc = "Step Into" },
		{ "<F12>", "<CMD>DapStepOut<CR>", desc = "Step Out" },
		{
			"<F17>",
			function()
				require("dap").run_last()
			end,
			desc = "Run Last",
		},
		{
			"<F21>",
			function()
				vim.ui.input({ prompt = "Breakpoint condition: " }, function(input)
					require("dap").set_breakpoint(input)
				end)
			end,
			desc = "Conditional Breakpoint",
		},
	},
	build = ":MasonUpdate",
	dependencies = {
		{ "mfussenegger/nvim-dap" },
		{ "jay-babu/mason-nvim-dap.nvim" },
		{ "theHamsta/nvim-dap-virtual-text" },
	},
	opts_extend = { "ensure_installed" },
	opts = {
		ensure_installed = {
			"stylua",
			"shfmt",
		},
	},
	---@param opts MasonSettings | {ensure_installed: string[]}
	config = function(_, opts)
		require("mason").setup(opts)
		require("mason-nvim-dap").setup({
			ensure_installed = { "codelldb" },
			handlers = {
				function(config)
					require("mason-nvim-dap").default_setup(config)
				end,
			},
			automatic_installation = false,
		})
		require("nvim-dap-virtual-text").setup()
		local mr = require("mason-registry")
		mr:on("package:install:success", function()
			vim.defer_fn(function()
				-- trigger FileType event to possibly load this newly installed LSP server
				require("lazy.core.handler.event").trigger({
					event = "FileType",
					buf = vim.api.nvim_get_current_buf(),
				})
			end, 100)
		end)

		mr.refresh(function()
			for _, tool in ipairs(opts.ensure_installed) do
				local p = mr.get_package(tool)
				if not p:is_installed() then
					p:install()
				end
			end
		end)
	end,
}
