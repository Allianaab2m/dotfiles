local components = {
	mode = function()
		local mode_state = vim.api.nvim_get_mode().mode
		if mode_state == ("i" or "ic" or "ix") then
			return require("utils").icons.mode.insert
		elseif mode_state == ("v" or "vs" or "V" or "Vs") then
			return require("utils").icons.mode.visual
		elseif mode_state == "t" then
			return require("utils").icons.mode.terminal
		else
			return require("utils").icons.vim
		end
	end,

	lsp = function()
		local msg = "Inactive"
		local buf_ft = vim.bo.filetype
		local clients = vim.lsp.get_clients({ bufnr = 0 })
		if next(clients) == nil then
			return msg
		end

		function table.unique(tbl)
			local check = {}
			local res = {}

			-- 整数型だけユニーク化
			for _, v in ipairs(tbl) do
				if not check[v] then
					check[v] = true
					res[1 + #res] = v
				end
			end

			-- キータイプはそのまま残す
			for k, v in pairs(tbl) do
				-- 整数以外
				if not (type(k) == "number" and k % 1 == 0) then
					res[k] = v
				end
			end
			return res
		end

		local lsp_names = {}
		for _, client in ipairs(clients) do
			local filetypes = client.config.filetypes
			if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
				table.insert(lsp_names, client.name)
			elseif client.name == "typos_lsp" then
				table.insert(lsp_names, client.name)
			end
		end

		for _, formatter in ipairs(require("conform").list_formatters(0)) do
			if formatter.available then
				table.insert(lsp_names, formatter.name)
			end
		end

		lsp_names = table.unique(lsp_names)

		return "Active" .. "(" .. table.concat(lsp_names, ", ") .. ")"
	end,
}

return {
	"nvim-lualine/lualine.nvim",
	cond = not is_vscode(),
	event = "VeryLazy",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		opts = {
			override = {
				ts = {
					icon = "",
					color = "#3178C6",
				},
			},
		},
	},
	opts = {
		sections = {
			lualine_x = {
				components.lsp,
			},
		},
	},
}
