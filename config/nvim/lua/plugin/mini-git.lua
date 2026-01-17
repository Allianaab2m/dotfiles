return {
	"nvim-mini/mini-git",
	version = false,
	cmd = { "Git" },
	config = function()
		require("mini.git").setup()
	end,
}
