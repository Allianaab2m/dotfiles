call ddu#custom#patch_global({
    \   'ui': 'ff',
    \   'sources': [{'name':'file','params':{}},{'name':'register'},{'name':'buffer'}],
    \   'sourceOptions': {
    \     '_': {
    \       'matchers': ['merge'],
    \       'columns': ['icon_filename']
    \     },
    \   },
    \   'kindOptions': {
    \     'ui_select': {
    \       'defaultAction': 'select'
    \     },
    \     'file': {
    \       'defaultAction': 'open',
    \     },
    \   },
    \   'filterParams': {
    \     'merge': #{
    \       filters: [
    \         #{name: 'matcher_kensaku', weight: 2.0},
    \         'matcher_fuse'
    \       ],
    \       unique: v:true,
    \     },
    \   },
    \   'uiParams': {
    \     'ff': {
    \       'split': 'floating',
    \       'startFilter': v:true,
    \       'floatingBorder': 'single'
    \     },
    \   }
    \ })

"ddu-key-setting
autocmd FileType ddu-ff call s:ddu_my_settings()
function! s:ddu_my_settings() abort
  nnoremap <buffer><silent> <CR>
        \ <Cmd>call ddu#ui#ff#do_action('itemAction')<CR>
  nnoremap <buffer><silent> <Space>
        \ <Cmd>call ddu#ui#ff#do_action('toggleSelectItem')<CR>
  nnoremap <buffer><silent> i
        \ <Cmd>call ddu#ui#ff#do_action('openFilterWindow')<CR>
  nnoremap <buffer><silent> q
        \ <Cmd>call ddu#ui#ff#do_action('quit')<CR>
  inoremap <buffer><silent> <C-q>
        \ <Cmd>call ddu#ui#ff#do_action('quit')<CR>
endfunction

autocmd FileType ddu-ff-filter call s:ddu_filter_my_settings()
function! s:ddu_filter_my_settings() abort
  nnoremap <buffer> <CR>
  \ <Cmd>call ddu#ui#ff#do_action('itemAction')<CR>
  nnoremap <buffer><silent> q
  \ <Cmd>call ddu#ui#ff#do_action('quit')<CR>
  inoremap <buffer> <CR>
  \ <Cmd>call ddu#ui#ff#do_action('itemAction')<CR>
  inoremap <buffer> <C-j>
  \ <Cmd>call ddu#ui#ff#execute("call cursor(line('.')+1,0)")<CR>
  inoremap <buffer> <C-k>
  \ <Cmd>call ddu#ui#ff#execute("call cursor(line('.')-1,0)")<CR>
  inoremap <buffer><silent> <C-q>
        \ <Cmd>call ddu#ui#ff#do_action('quit')<CR>
endfunction

"ddu keymapping.
nnoremap <SID>[ug] <Nop>
nmap ; <SID>[ug]

nnoremap <silent> <SID>[ug]b :<C-u>Ddu buffer<CR>
nnoremap <silent> <SID>[ug]r :<C-u>Ddu register<CR>
nnoremap <silent> <SID>[ug]n :<C-u>Ddu file -source-param-new -volatile<CR>
nnoremap <silent> <SID>[ug]f :<C-u>Ddu file<CR>
