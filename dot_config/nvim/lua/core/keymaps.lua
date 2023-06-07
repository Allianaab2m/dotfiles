local key = vim.keymap.set
local opts = { silent = true }

key("", "<Space>", "<Nop>", opts)

key("i", "jk", "<Esc>", opts)
key("i", "jj", "<Esc>", opts)

key("n", "L", "<Cmd>bnext<CR>", opts)
key("n", "H", "<Cmd>bprev<CR>", opts)
key("n", "<Leader>e", "<Cmd>Neotree<CR>", opts)

--Telescope
key("n", ";f", "<Cmd>Telescope find_files<CR>", opts)
key("n", ";g", "<Cmd>Telescope kensaku<CR>", opts)
key("n", ";lg", "<Cmd>Telescope live_grep<CR>", opts)
key("n", ";b", "<Cmd>Telescope buffers<CR>", opts)

--Toggleterm
key("n", "<Leader>t", "<Cmd>ToggleTerm<CR>", opts)

key("v", "<", "<gv", opts)
key("v", ">", ">gv", opts)
