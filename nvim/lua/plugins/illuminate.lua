return {
	"https://github.com/RRethy/vim-illuminate",
	init = function()
		vim.g.Illuminate_delay = 500
		require("utils").on_attach(function(client, bufnr)
			require("illuminate").on_attach(client)
		end)
	end,
}
