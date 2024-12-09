return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	version = false,
	dependencies = {
		{
			-- {
			-- 	"nvim-telescope/telescope-fzf-native.nvim",
			-- 	build = "make",
			-- 	config = function()
			-- 		require("utils").on_load("telescope.nvim", function()
			-- 			require("telescope").load_extension("fzf")
			-- 		end)
			-- 	end,
			-- },
		},
	},
	keys = {
		{
			"<leader>,",
			"<Cmd>Telescope buffers sort_mru=true sort_lastused=true<CR>",
			desc = "Switch buffer",
		},
		{
			"<leader>/",
			"<Cmd>Telescope live_grep<CR>",
			desc = "Grep(Root dir)",
		},
		{
			"<leader>:",
			"<Cmd>Telescope command_history<CR>",
			desc = "Command history",
		},
		{
			"<leader><space>",
			"<Cmd>Telescope find_files<CR>",
			desc = "Find files(Root dir)",
		},

		-- find
		{ "<leader>fb", "<Cmd>Telescope buffers sort_mru=true sort_lastused=true<CR>", desc = "Switch buffer" },
		{ "<leader>ff", "<Cmd>Telescope find_files<CR>", desc = "Find files(Root dir)" },
		{ "<leader>fg", "<Cmd>Telescope git_files<CR>", desc = "Find files(git)" },

		-- git
		{ "<leader>gc", "<Cmd>Telescope git_commits<CR>", desc = "Commits" },
		{ "<leader>gs", "<Cmd>Telescope git_status<CR>", desc = "Status" },

		--search
		{ "<leader>s", "<Cmd>Telescope registers<CR>", desc = "Register" },
		{ "<leader>sa", "<Cmd>Telescope autocommands<CR>", desc = "Auto Commands" },
		{ "<leader>sb", "<Cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "Buffer" },
		{ "<leader>sc", "<Cmd>Telescope command_history<CR>", desc = "Command History" },
		{ "<leader>sC", "<Cmd>Telescope commands<CR>", desc = "Commands" },
		{ "<leader>sd", "<Cmd>Telescope diagnostics bufnr=0<CR>", desc = "Document Diagnostics" },
		{ "<leader>sD", "<Cmd>Telescope diagnostics<CR>", desc = "Workspace Diagnostics" },
		{ "<leader>sg", "<Cmd>Telescope live_grep", desc = "Grep (Root Dir)" },
		{ "<leader>sh", "<Cmd>Telescope help_tags<CR>", desc = "Help Pages" },
		{ "<leader>sH", "<Cmd>Telescope highlights<CR>", desc = "Search Highlight Groups" },
		{ "<leader>sj", "<Cmd>Telescope jumplist<CR>", desc = "Jumplist" },
		{ "<leader>sk", "<Cmd>Telescope keymaps<CR>", desc = "Key Maps" },
		{ "<leader>sl", "<Cmd>Telescope loclist<CR>", desc = "Location List" },
		{ "<leader>sM", "<Cmd>Telescope man_pages<CR>", desc = "Man Pages" },
		{ "<leader>sm", "<Cmd>Telescope marks<CR>", desc = "Jump to Mark" },
		{ "<leader>so", "<Cmd>Telescope vim_options<CR>", desc = "Options" },
		{ "<leader>sR", "<Cmd>Telescope resume<CR>", desc = "Resume" },
		{ "<leader>sq", "<Cmd>Telescope quickfix<CR>", desc = "Quickfix List" },
		{
			"<leader>ss",
			function()
				require("telescope.builtin").lsp_document_symbols({
					symbols = require("utils").get_kind_filter(),
				})
			end,
			desc = "Go to Symbol",
		},
		{
			"<leader>sS",
			function()
				require("telescope.builtin").lsp_dynamic_workspace_symbols({
					symbols = require("utils").get_kind_filter(),
				})
			end,
			desc = "Go to Symbol(Workspace)",
		},
	},
	opts = function()
		local actions = require("telescope.actions")
		-- local open_with_trouble = require("trouble.sources.telescope").open

		return {
			defaults = {
				prompt_prefix = " ",
				selection_caret = " ",
				-- open files in the first window that is an actual file.
				-- use the current window if no other window is available.
				get_selection_window = function()
					local wins = vim.api.nvim_list_wins()
					table.insert(wins, 1, vim.api.nvim_get_current_win())
					for _, win in ipairs(wins) do
						local buf = vim.api.nvim_win_get_buf(win)
						if vim.bo[buf].buftype == "" then
							return win
						end
					end
					return 0
				end,
				mappings = {
					i = {
						-- ["<c-t>"] = open_with_trouble,
						-- ["<a-t>"] = open_with_trouble,
						["<C-Down>"] = actions.cycle_history_next,
						["<C-Up>"] = actions.cycle_history_prev,
						["<C-f>"] = actions.preview_scrolling_down,
						["<C-b>"] = actions.preview_scrolling_up,
					},
					n = {
						["q"] = actions.close,
					},
				},
			},
			pickers = {
				find_files = {
					find_command = "rg",
					hidden = true,
				},
			},
		}
	end,
}
