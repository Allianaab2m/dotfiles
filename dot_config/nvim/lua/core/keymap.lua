-- Shortcut
local key = vim.keymap.set
local opts = { silent = true }

key('', '<Space>', '<Nop>', opts)
vim.g.mapleader = " " -- <leader> = <Space>

-- Normal --
-- Normal --
-- Better window navigation
key("n", "<C-h>", "<C-w>h", opts)
key("n", "<C-j>", "<C-w>j", opts)
key("n", "<C-k>", "<C-w>k", opts)
key("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
key("n", "<C-Up>", ":resize -2<CR>", opts)
key("n", "<C-Down>", ":resize +2<CR>", opts)
key("n", "<C-Left>", ":vertical resize -2<CR>", opts)
key("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
key("n", "<S-l>", ":bnext<CR>", opts)
key("n", "<S-h>", ":bprevious<CR>", opts)

-- Clear highlights
key("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

-- Close buffers
key("n", "<S-q>", "<cmd>Bdelete!<CR>", opts)

-- Better paste
key("v", "p", '"_dP', opts)

-- Insert --
-- Press jk fast to enter
key("i", "jk", "<ESC>", opts)
key("i", "jj", "<ESC>", opts)
key("i", "っｊ", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
key("v", "<", "<gv", opts)
key("v", ">", ">gv", opts)

