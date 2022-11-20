require('bufferline').setup({
  options = {
    indicator = {
      style = 'underline'
    },
    diagnostics = 'nvim_lsp',
    diagnostics_update_in_insert = true,
    separator_style = 'slant'
  }
})
