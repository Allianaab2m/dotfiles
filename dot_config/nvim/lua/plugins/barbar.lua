return {
  "https://github.com/romgrk/barbar.nvim",
  dependencies = {
    "https://github.com/lewis6991/gitsigns.nvim",
    "https://github.com/nvim-tree/nvim-web-devicons",
  },
  init = function() vim.g.barbar_auto_setup = true end,
  event = "VeryLazy",
  opts = {
  },
  version = "^1.0.0",
}
