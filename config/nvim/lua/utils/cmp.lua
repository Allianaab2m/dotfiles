local M = {}

---@alias Placeholder {n:number, text:string}

---@param snippet string
---@param fn fun(placeholder:Placeholder):string
---@return string
M.snippet_replace = function(snippet, fn)
	return snippet:gsub("%$%b{}", function(m)
		local n, name = m:match("^%${(%d+):(.+)}$")
		return n and fn({ n = n, text = name }) or m
	end) or snippet
end

---@param snippet string
---@return string
M.snippet_preview = function(snippet)
	local ok, parsed = pcall(function()
		return vim.lsp._snippet_grammar.parse(snippet)
	end)
	return ok and tostring(parsed)
		or M.snippet_replace(snippet, function(placeholder)
			return M.cmp.snippet_preview(placeholder.text)
		end):gsub("%$0", "")
end

M.snippet_fix = function(snippet)
	local texts = {} ---@type table<number, string>
	return M.snippet_replace(snippet, function(placeholder)
		texts[placeholder.n] = texts[placeholder.n] or M.snippet_preview(placeholder.text)
		return "${" .. placeholder.n .. ":" .. texts[placeholder.n] .. "}"
	end)
end

M.expand = function(snippet)
	local session = vim.snippet.active() and vim.snippet._session or nil
	local ok, err = pcall(vim.snippet.expand, snippet)

	if not ok then
		local fixed = M.snippet_fix(snippet)
		ok = pcall(vim.snippet.expand, fixed)

		local msg = ok and "Failed to parse snippet,\nbut was able to fix it automatically."
			or ("Failed to parse snippet.\n" .. err)
		require("utils.log").info(msg)
	end

	if session then
		vim.snippet._session = session
	end
end

---@param opts? {select: boolean, behavior: cmp.ConfirmBehavior}
M.confirm = function(opts)
	local cmp = require("cmp")
	opts = vim.tbl_extend("force", {
		select = true,
		behavior = cmp.ConfirmBehavior.Insert,
	}, opts or {})
	return function(fallback)
		if cmp.core.view:visible() or vim.fn.pumvisible() == 1 then
			require("utils").create_undo()
			if cmp.confirm(opts) then
				return
			end
		end
		return fallback()
	end
end

return M
