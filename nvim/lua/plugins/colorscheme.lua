return {
  {
    "dasupradyumna/midnight.nvim",
    lazy = false,
    enabled = false,
    priority = 1000,
    opts = function()
      vim.cmd.colorscheme("midnight")
    end,
  },
  {
    "cocopon/iceberg.vim",
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("iceberg")
    end,
  },
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    name = "catppuccin",
    config = function()
      require("catppuccin").setup({
        term_colors = true,
        transparent_background = false,
        styles = {
          comments = { "italic" },
          conditionals = {},
          loops = {},
          functions = { "italic" },
          keywords = { "bold", "italic" },
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
        },
        color_overrides = {
          mocha = {
            base = "#000000",
            mantle = "#000000",
            crust = "#000000"
          }
        },
        custom_highlights = function(C)
          return {
            CmpItemKindSnippet = { fg = C.base, bg = C.mauve },
            CmpItemKindKeyword = { fg = C.base, bg = C.red },
            CmpItemKindText = { fg = C.base, bg = C.teal },
            CmpItemKindMethod = { fg = C.base, bg = C.blue },
            CmpItemKindConstructor = { fg = C.base, bg = C.blue },
            CmpItemKindFunction = { fg = C.base, bg = C.blue },
            CmpItemKindFolder = { fg = C.base, bg = C.blue },
            CmpItemKindModule = { fg = C.base, bg = C.blue },
            CmpItemKindConstant = { fg = C.base, bg = C.peach },
            CmpItemKindField = { fg = C.base, bg = C.green },
            CmpItemKindProperty = { fg = C.base, bg = C.green },
            CmpItemKindEnum = { fg = C.base, bg = C.green },
            CmpItemKindUnit = { fg = C.base, bg = C.green },
            CmpItemKindClass = { fg = C.base, bg = C.yellow },
            CmpItemKindVariable = { fg = C.base, bg = C.flamingo },
            CmpItemKindFile = { fg = C.base, bg = C.blue },
            CmpItemKindInterface = { fg = C.base, bg = C.yellow },
            CmpItemKindColor = { fg = C.base, bg = C.red },
            CmpItemKindReference = { fg = C.base, bg = C.red },
            CmpItemKindEnumMember = { fg = C.base, bg = C.red },
            CmpItemKindStruct = { fg = C.base, bg = C.blue },
            CmpItemKindValue = { fg = C.base, bg = C.peach },
            CmpItemKindEvent = { fg = C.base, bg = C.blue },
            CmpItemKindOperator = { fg = C.base, bg = C.blue },
            CmpItemKindTypeParameter = { fg = C.base, bg = C.blue },
            CmpItemKindCopilot = { fg = C.base, bg = C.teal },

          }
        end
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  }
}
