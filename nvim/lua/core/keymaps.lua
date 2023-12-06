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

vim.cmd [[
" カーソルがインデント内部ならtrue
function! s:in_indent() abort
  return col('.') <= indent('.')
endfunction

" カーソルがインデントとずれた位置ならtrue
function! s:not_fit_indent() abort
  return !!((col('.') - 1) % shiftwidth())
endfunction

function! s:quantized_h(cnt = 1) abort
  if a:cnt > 1 || !&expandtab
    execute printf('normal! %sh', a:cnt)
    return
  endif
  normal! h
  while s:in_indent() && s:not_fit_indent()
    normal! h
  endwhile
endfunction

function! s:quantized_l(cnt = 1) abort
  if a:cnt > 1 || !&expandtab
    execute printf('normal! %sl', a:cnt)
    return
  endif
  normal! l
  while s:in_indent() && s:not_fit_indent()
    normal! l
  endwhile
endfunction

noremap h <cmd>call <sid>quantized_h(v:count1)<cr>
noremap l <cmd>call <sid>quantized_l(v:count1)<cr>
]]
