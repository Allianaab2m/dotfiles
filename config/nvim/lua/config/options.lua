vim.g.mapleader = t("<Space>")

vim.opt.backup = true
vim.opt.backupdir = vim.fn.expand(vim.fn.stdpath("cache") .. "/.vim_backup")
vim.opt.swapfile = false
vim.opt.writebackup = true
vim.opt.autoread = true
vim.opt.hidden = true
vim.opt.mouse = "a"

vim.opt.shortmess:append("I")
vim.opt.clipboard:append({ "unnamedplus" })

vim.opt.wrap = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.virtualedit = "onemore"
vim.opt.visualbell = true
vim.opt.errorbells = false
vim.opt.showmatch = true
vim.opt.smoothscroll = true
-- vim.opt.signcolumn = "yes"

vim.opt.fenc = "utf-8"
local tabwidth = 2
vim.opt.tabstop = tabwidth
vim.opt.softtabstop = tabwidth
vim.opt.shiftwidth = tabwidth
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.nrformats:remove({ "unsigned", "octal" })

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.wrapscan = true
vim.opt.wildmode = { list = "longest" }

vim.opt.undolevels = 1000
vim.opt.history = 1000

vim.opt.scrolloff = 4

vim.opt.list = true

vim.opt.listchars = {
	tab = "▸▹┊",
	trail = "▫",
	nbsp = "␣",
	extends = "❯",
	precedes = "❮",
}

vim.opt.pumblend = 10
vim.opt.laststatus = 0
-- vim.opt.cmdheight = 0

if vim.g.vscode then
	vim.opt.cmdheight = 1
else
	vim.opt.cmdheight = 0
end

vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldlevel = 99
vim.o.foldmethod = "expr"
