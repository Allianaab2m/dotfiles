return {
	"https://github.com/hrsh7th/nvim-cmp",
	version = false,
	event = { "InsertEnter", "CmdlineEnter" },
	dependencies = {
		"https://github.com/hrsh7th/cmp-nvim-lsp",
		"https://github.com/hrsh7th/cmp-path",
		"https://github.com/L3MON4D3/LuaSnip",
		"https://github.com/saadparwaiz1/cmp_luasnip",
		"https://github.com/rafamadriz/friendly-snippets",
		"https://github.com/hrsh7th/cmp-cmdline",
	},
	opts = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local has_words_before = function()
			unpack = unpack or table.unpack
			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
			return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
		end

		return {
			completion = {
				completeopt = "menu,menuone,noinsert",
			},
			window = {
				completion = {
					winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
					border = "none",
					col_offset = -3,
					side_padding = 1,
				},
				documentation = {
					border = "single",
				},
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
					luasnip.lsp_expand(args.body)
				end,
			},
			sources = {
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "path" },
				{ name = "skkeleton" },
			},
			experimental = {
				ghost_text = {
					hl_group = "LspCodeLens",
				},
			},
			mapping = {
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif require("luasnip").expand_or_jumpable() then
						require("luasnip").expand_or_jump()
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
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping({
					i = function(fallback)
						if cmp.visible() then
							cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
						else
							fallback()
						end
					end,
					s = cmp.mapping.confirm({ select = true }),
					c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
				}),
			},
			sorting = {
				priority_weight = 2,
				comparators = {
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
		},
			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					name = "buffer",
				},
			}),
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline({
					["<CR>"] = {
						c = function(fallback)
							fallback()
						end,
					},
				}),
				sources = cmp.config.sources({
					{ name = "buffer" },
					{ name = "cmdline" },
				}),
			})
	end,
}
