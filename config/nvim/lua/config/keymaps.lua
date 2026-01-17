vim.g.completion_trigger_character = "."
local map = vim.keymap.set

-- Close tab
map("n", "<leader>q", "<cmd>tabclose<cr>", { desc = "Close Tab" })

-- Swap :, ;
map("n", ";", ":")
map("n", ":", ";")

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- jj, JJ, jk, JK => <Esc>
map("i", "jj", "<Esc>")
map("i", "JJ", "<Esc>")
map("i", "jk", "<Esc>")
map("i", "JK", "<Esc>")

-- disable key
map({ "n", "v" }, "s", "<Nop>")
map({ "n", "v" }, "S", "<Nop>")
map("n", "gh", "<Nop>")
map("n", "gj", "<Nop>")
map("n", "gk", "<Nop>")
map("n", "gl", "<Nop>")

map("n", "gH", "H")
map("n", "gM", "M")
map("n", "gL", "L")

map("n", "H", "<cmd>bprev<cr>")
map("n", "L", "<cmd>bnext<cr>")

-- Auto indent
map("n", "i", function()
	return vim.fn.len(vim.fn.getline(".")) ~= 0 and "i" or '"_cc'
end, { expr = true, silent = true })
map("n", "A", function()
	return vim.fn.len(vim.fn.getline(".")) ~= 0 and "A" or '"_cc'
end, { expr = true, silent = true })

-- Split window
map("n", "ss", "<cmd>split<cr>")
map("n", "sv", "<cmd>vsplit<cr>")

-- Terminal mappings
map("t", "<esc><esc>", "<c-\\><c-n>")
map("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to Left Window" })
map("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to Lower Window" })
map("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to Upper Window" })
map("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to Right Window" })
map("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
map("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })

-- delete w/o yank
map({ "n", "v" }, "x", '"_x')
map({ "n", "v" }, "X", '"_d$')

-- quickfix cclose => <leader>x
map({ "n", "v" }, "<leader>x", vim.cmd.cclose)
-- redo <C-r> => U
map("n", "U", "<C-r>")
-- matching bracket % => M
map("n", "M", "%")
-- keep cursor position after yank in v
map("x", "y", "mzy`z")

-- indent in v
map("x", "<", "<gv")
map("x", ">", ">gv")

-- a operator => 2i
-- @see https://zenn.dev/vim_jp/articles/2024-06-05-vim-middle-class-features
for _, quote in ipairs({ '"', "'", "`" }) do
	vim.keymap.set({ "x", "o" }, "a" .. quote, "2i" .. quote)
end
