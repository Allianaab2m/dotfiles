local options = {
    backup = false,
    clipboard = "unnamed",
    laststatus = 3,
    conceallevel = 0,
    hlsearch = true,
    ignorecase = true,
    mouse = "a",
    pumheight = 10,
    relativenumber = true,
    number = true,
    showmode = false,
    showtabline = 2,
    smartcase = true,
    smartindent = true,
    signcolumn = "yes",
    splitbelow = true,
    splitright = true,
    swapfile = false,
    timeoutlen = 200,
    undofile = true,
    updatetime = 500,
    writebackup = false,
    expandtab = true,
    shiftwidth = 2,
    tabstop = 2,
    cursorline = true,
    numberwidth = 2,
    wrap = true,
    linebreak = true,
    scrolloff = 8,
    sidescrolloff = 8,
    termguicolors = true,
}

vim.opt.shortmess:append("c")

for k, v in pairs(options) do
    vim.o[k] = v
end

if vim.fn.has("wsl") then
    vim.g.clipboard = {
        name = "win32yank-wsl",
        copy = {
            ["+"] = "win32yank.exe -i --crlf",
            ["*"] = "win32yank.exe -i --crlf",
        },
        paste = {
            ["+"] = "win32yank.exe -o --crlf",
            ["*"] = "win32yank.exe -o --crlf",
        }
    }
end

vim.cmd([[set whichwrap+=<,>,[,],h,l]])
vim.cmd([[set iskeyword+=-]])
vim.cmd([[set formatoptions-=cro]])
vim.cmd([[language en_US.utf8]])
