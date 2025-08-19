return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	opts = function()
		require("copilot").setup({
			suggestion = {
				auto_trigger = true,
				hide_during_completion = false,
				keymap = {
					accept = "<C-e>",
				},
			},
			filetypes = {
				markdown = true,
				gitcommit = true,
				["*"] = function()
					-- disable for files with specific names
					local fname = vim.fs.basename(vim.api.nvim_buf_get_name(0))
					local disable_patterns = { "env", "conf", "local", "private" }
					return vim.iter(disable_patterns):all(function(pattern)
						return not string.match(fname, pattern)
					end)
				end,
			},
		})
		local hl = vim.api.nvim_get_hl(0, { name = "Comment" })
		vim.api.nvim_set_hl(0, "CopilotSuggestion", vim.tbl_extend("force", hl, { underline = true }))
	end,
}
