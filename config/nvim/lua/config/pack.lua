require("core.plugin").init()
local lazy = require("lazy")

if vim.env.NVIM_COLORSCHEME == nil then
	vim.env.NVIM_COLORSCHEME = "catppuccin"
end

lazy.setup({
	spec = {
		{ import = "plugin" },
	},
	defaults = { lazy = true },
	install = { missing = true, colorscheme = { "0x96f" } },
	checker = { enabled = false },
	concurrency = 64,
	performance = {
		cache = {
			enabled = true,
		},
		rtp = {
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"netrw",
				"tarPlugin",
				"tar",
				"tohtml",
				"tutor",
				"zipPlugin",
				"zip",
			},
		},
	},
})
