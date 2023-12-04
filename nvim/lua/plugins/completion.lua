foo = "bar"
return {
	{
		"hrsh7th/nvim-cmp",
		version = false,
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			--"FelipeLema/cmp-async-path",
			"hrsh7th/cmp-path",
			--"hrsh7th/vim-vsnip",
			--"hrsh7th/cmp-vsnip",
			{
				"L3MON4D3/LuaSnip",
				event = { "InsertEnter" },
				opts = function()
					local ls = require("luasnip")
					local sn = ls.snippet_node
					local t = ls.text_node
					local i = ls.insert_node
					local d = ls.dynamic_node
					local f = ls.function_node
					local postfix = require("luasnip.extras.postfix").postfix
					local ts_postfix = require("luasnip.extras.treesitter_postfix").treesitter_postfix
					local postfix_builtin = require("luasnip.extras.treesitter_postfix").builtin

					local const_pf = postfix(".const", {
						d(1, function(_, parent)
							return sn(nil, {
								t("const "),
								i(1, "var"),
								t(" = "),
								t(parent.env.POSTFIX_MATCH),
							})
						end),
					})

					local let_pf = postfix(".let", {
						d(1, function(_, parent)
							return sn(nil, {
								t("let "),
								i(1, "var"),
								t(" = "),
								t(parent.env.POSTFIX_MATCH),
							})
						end),
					})

					local if_pf = postfix(".if", {
						d(1, function(_, parent)
							return sn(nil, {
								t("if ("),
								t(parent.env.POSTFIX_MATCH),
								t(") {"),
								i(1),
								t("}"),
							})
						end),
					})

					local local_pf = postfix(".local", {
						d(1, function(_, parent)
							return sn(nil, {
								t("local "),
								i(1, "var"),
								t(" = "),
								t(parent.env.POSTFIX_MATCH),
							})
						end),
					})

					ls.add_snippets("c", { if_pf })
					ls.add_snippets("javascript", { const_pf, let_pf, if_pf })
					ls.add_snippets("typescript", { const_pf, let_pf, if_pf })
					ls.add_snippets("lua", { local_pf })
				end,
			},
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
			"hrsh7th/cmp-cmdline",
		},
		opts = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local has_words_before = function()
				unpack = unpack or table.unpack
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			local feedkey = function(key, mode)
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
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
	},
}
