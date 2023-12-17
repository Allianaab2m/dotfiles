return {
  "https://github.com/hrsh7th/vim-searchx",
  keys = {
    { "?", "<Cmd>call searchx#start({ 'dir': 0 })<CR>", mode = "n", desc = "Searchx ?" },
    { "/", "<Cmd>call searchx#start({ 'dir': 1 })<CR>", mode = "n", desc = "Searchx ?" },
    { "?", "<Cmd>call searchx#start({ 'dir': 0 })<CR>", mode = "x", desc = "Searchx ?" },
    { "/", "<Cmd>call searchx#start({ 'dir': 1 })<CR>", mode = "x", desc = "Searchx ?" },
    { "N", "<Cmd>call searchx#prev_dir()<CR>",          mode = "n", desc = "Searchx ?" },
    { "n", "<Cmd>call searchx#next_dir()<CR>",          mode = "n", desc = "Searchx ?" },
    { "N", "<Cmd>call searchx#prev_dir()<CR>",          mode = "x", desc = "Searchx ?" },
    { "n", "<Cmd>call searchx#next_dir()<CR>",          mode = "x", desc = "Searchx ?" },
  },
  config = function()
    vim.cmd [[
      let g:searchx = {}

      " Auto jump if the recent input matches to any marker.
      let g:searchx.auto_accept = v:true

      " The scrolloff value for moving to next/prev.
      let g:searchx.scrolloff = &scrolloff

      " To enable scrolling animation.
      let g:searchx.scrolltime = 500

      " To enable auto nohlsearch after cursor is moved
      let g:searchx.nohlsearch = {}
      let g:searchx.nohlsearch.jump = v:true

      " Marker characters.
      let g:searchx.markers = split('ASDFGHJKLQWERTYUIOPZXCVBNM', '.\zs')

      " Convert search pattern.
      function g:searchx.convert(input) abort
        if a:input !~# '\k'
          return '\V' .. a:input
        endif
        return a:input[0] .. substitute(a:input[1:], '\\\@<! ', '.\\{-}', 'g')
      endfunction
    ]]
  end
}
