local M = {}

M.treesitterSetup = function()
  import("nvim-treesitter.configs", function (treesitterconf)
    treesitterconf.setup({
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
  end)
end

M.contextSetup = function ()
  import("treesitter-context", function (ts_context)
    ts_context.setup({})
  end)
end

return M
