local blacklist = {
	"emobi-core",
	"emobi-web",
	"emobi-dashboard",
}

local is_blacklisted = function(opts)
	return vim.tbl_contains(blacklist, opts.workspace)
end

return {
	"vyfor/cord.nvim",
	build = ":Cord update",
	event = "VeryLazy",
	opts = {
		editor = {
			tooltip = "Neovim",
		},
		display = {
			theme = "catppuccin",
		},
		text = {
			viewing = function(opts)
				return is_blacklisted(opts) and "Viewing a file" or ("Viewing " .. opts.filename)
			end,
			editing = function(opts)
				return is_blacklisted(opts) and "Editing a file" or ("Editing " .. opts.filename)
			end,
			workspace = function(opts)
				return is_blacklisted(opts) and "In a secret workspace" or ("Working on " .. opts.workspace)
			end,
		},
		hooks = {
			workspace_change = function(opts)
				if is_blacklisted(opts) then
					opts.manager:hide()
				else
					opts.manager:resume()
				end
			end,
		},
	}, -- calls require('cord').setup()
}
