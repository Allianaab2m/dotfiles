return {
	"https://github.com/L3MON4D3/LuaSnip",
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
}
