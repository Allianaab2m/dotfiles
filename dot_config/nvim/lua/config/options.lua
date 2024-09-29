local opt = vim.opt

opt.autowrite = true
opt.clipboard = "unnamedplus"
opt.conceallevel = 2
opt.confirm = true
opt.cursorline = true
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}
opt.foldlevel = 99
opt.formatoptions = "jcroqlnt"
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true
opt.inccommand = "nosplit"
opt.jumpoptions = "view"
opt.laststatus = 3
opt.linebreak = true
opt.list = true
opt.mouse = "a"
opt.number = true
opt.relativenumber = true
opt.scrolloff = 4
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.shiftround = true
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 0
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.showmode = false
opt.sidescrolloff = 8
opt.signcolumn = "yes"
opt.smartcase = true
opt.smartindent = true
opt.splitbelow = true
opt.splitkeep = "screen"
opt.splitright = true
opt.termguicolors = true
opt.timeoutlen = vim.g.vscode and 1000 or 300
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200
opt.virtualedit = "block"
opt.wildmode = "longest:full,full"
opt.winminwidth = 5
opt.wrap = false
opt.smoothscroll = true
opt.pumheight = 10

if vim.fn.has("wsl") == 1 then
  vim.g.clipboard = {
    name = "yank (wsl)",
    copy = {
      ["+"] = 'win32yank.exe -i',
      ["*"] = 'win32yank.exe -i',
    },
    paste = {
      ["+"] = 'win32yank.exe -o',
      ["*"] = 'win32yank.exe -o',
    },
    cache_enabled = true
  }
end
