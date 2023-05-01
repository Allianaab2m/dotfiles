local key = vim.keymap.set
local opts = { silent = true }

key("", "<Space>", "<Nop>", opts)

key("i", "jk", "<Esc>", opts)
key("i", "jj", "<Esc>", opts)
