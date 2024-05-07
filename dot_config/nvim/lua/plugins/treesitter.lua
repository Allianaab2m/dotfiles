return {
  "https://github.com/nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = "VeryLazy",
  dependencies = {
    "https://github.com/windwp/nvim-ts-autotag",
  },
  config = function ()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      ensure_installed = {
        "c",
        "lua",
        "typescript",
        "javascript",
        "vim",
        "markdown",
        "markdown_inline",
        "comment"
      },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
      autotag = { enable = true },
    })
  end
}
