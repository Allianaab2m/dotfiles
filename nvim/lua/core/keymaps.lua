local key = vim.keymap.set
local opts = { noremap = true, silent = true }

key("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

key("i", "jj", "<Esc>", opts)
key("i", "jk", "<Esc>", opts)

key("n", "L", "<Cmd>bnext<CR>", opts)
key("n", "H", "<Cmd>bprev<CR>", opts)

key("v", "<", "<gv", opts)
key("v", ">", ">gv", opts)

key("n", "<Leader>t", "<Cmd>ToggleTerm<CR>", opts)
key("t", "<Esc>", "<C-\\><C-n>", opts)

key("n", "<C-h>", "<C-w>h")
key("n", "<C-j>", "<C-w>j")
key("n", "<C-k>", "<C-w>k")
key("n", "<C-l>", "<C-w>l")

key("n", "<C-Up>", ":resize -2<CR>", opts)
key("n", "<C-Down>", ":resize +2<CR>", opts)
key("n", "<C-Left>", ":vertical resize -2<CR>", opts)
key("n", "<C-Right>", ":vertical resize +2<CR>", opts)
