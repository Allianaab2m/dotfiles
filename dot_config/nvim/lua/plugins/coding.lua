return {
	{
		"L3MON4D3/LuaSnip",
		build = (not jit.os:find("Windows")) and "echo -e 'NOTE: jsregexp is optional, so not a big deal if it failed'"
			or nil,
		dependencies = {
			"rafamadriz/friendly-snippets",
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
			end,
		},
		opts = {
			history = true,
			delete_check_events = "TextChanged",
		},
	},

	{
		"hrsh7th/nvim-cmp",
		version = false,
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			{
				"zbirenbaum/copilot-cmp",
				dependencies = "zbirenbaum/copilot.lua",
				opts = {},
				config = function(_, opts)
					local copilot_cmp = require("copilot_cmp")
					copilot_cmp.setup(opts)
					require("utils").on_attach(function(client)
						if client.name == "copilot" then
							copilot_cmp._on_insert_enter()
						end
					end)
				end,
			},
		},
		opts = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			local has_words_before = function()
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end
			local confirm_copilot = cmp.mapping.confirm({
				select = true,
				behavior = cmp.ConfirmBehavior.Replace,
			})
			return {
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				window = {
					completion = {
						winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
						col_offset = -3,
						side_padding = 0,
					},
					documentation = cmp.config.window.bordered({ border = "single" }),
				},
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = function(_, item)
						local icons = require("utils").icons.kinds
						if icons[item.kind] then
							item.menu = "    (" .. item.kind .. ")"
							item.kind = " " .. icons[item.kind] .. " "
						end

						return item
					end,
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = {
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
					["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = false
          }),
					["<C-e>"] = cmp.mapping.abort(),
				},
				sources = cmp.config.sources({
					{ name = "copilot", group_index = 2 },
					{ name = "nvim_lsp", group_index = 2 },
					{ name = "luasnip", group_index = 2 },
					{ name = "buffer", group_index = 2 },
					{ name = "path", group_index = 2 },
				}),
				experimental = {
					ghost_text = {
						hl_group = "LspCodeLens",
					},
				},
				sorting = {
					priority_weight = 2,
					comparators = {
						require("copilot_cmp.comparators").prioritize,
						cmp.config.compare.offset,
						cmp.config.compare.score,
						cmp.config.compare.recently_used,
						cmp.config.compare.locality,
						cmp.config.compare.kind,
						cmp.config.compare.sort_text,
						cmp.config.compare.length,
						cmp.config.compare.order,
					},
				},
			}
		end,
	},

	{
		"echasnovski/mini.pairs",
		event = "VeryLazy",
		config = function(_, opts)
			require("mini.pairs").setup(opts)
		end,
	},

  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    config = function (_, opts)
      require("mini.comment").setup(opts)
    end
  },

  {
    "stevearc/overseer.nvim",
    cmd = "OverseerRun",
    opts = {},
  },
}
