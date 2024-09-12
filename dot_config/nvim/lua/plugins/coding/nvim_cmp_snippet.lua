return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		{
			"garymjr/nvim-snippets",
			opts = {
				friendly_snippets = true,
			},
			dependencies = { "rafamadriz/friendly-snippets" },
		},
	},
	opts = function(_, opts)
		opts.snippet = {
			expand = function(item)
				return require("utils.cmp").expand(item.body)
			end,
		}
		if require("utils").has("nvim-snippets") then
			table.insert(opts.sources, { name = "snippets" })
		end
	end,
}
