return {
	"nvim-mini/mini.bufremove",
	version = "*",
	cmd = { "Bdelete" },
	config = function()
		require("mini.bufremove").setup()

		vim.api.nvim_create_user_command("Bdelete", function()
			MiniBufremove.delete()
		end, {})
	end,
}
