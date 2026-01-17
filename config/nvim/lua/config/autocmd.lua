vim.api.nvim_create_autocmd("BufReadPost", {
	desc = "Auto jump to last position",
	group = vim.api.nvim_create_augroup("auto-last-position", { clear = true }),
	callback = function(args)
		local position = vim.api.nvim_buf_get_mark(args.buf, [["]])
		local winid = vim.fn.bufwinid(args.buf)
		pcall(vim.api.nvim_win_set_cursor, winid, position)
	end,
})
