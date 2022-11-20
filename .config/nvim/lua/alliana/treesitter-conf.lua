local M = {}

M.treesitterSetup = function()
  require('nvim-treesitter.configs').setup({
    highlight = {
      enable = true,
      disable = {
      }
    },
    ensure_installed = {
      'javascript',
      'typescript',
      'lua',
      'json',
      'jsdoc',
      'tsx',
      'markdown',
      'rust'
    },
    context_commentstring = {
      enable = true,
      config = {
        typescript = { __default = '// %s', __multiline = '/* %s */' },
        lua = { __default = '-- %s', __multiline = '--[[ %s ]]'}
      },
      enable_autocmd = false
    },
    rainbow = {
      enable = true
    },
    playglound = {
      enable = true
    }
  })
end

M.contextSetup = function ()
  require('treesitter-context').setup({})
end

return M
