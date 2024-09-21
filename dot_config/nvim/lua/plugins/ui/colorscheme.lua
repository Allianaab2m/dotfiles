return {
  {
    "killitar/obscure.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("obscure").setup({
        styles = {
          comments = { italic = true },
        },
        on_highlights = function(hl, c)
          hl.CmpItemAbbrDeprecated = { fg = c.gray3, bg = "NONE", strikethrough = true }
          hl.CmpItemAbbrMatch = { fg = c.blue, bg = "NONE", bold = true }
          hl.CmpItemAbbrMatchFuzzy = { fg = c.blue, bg = "NONE", bold = true }
          hl.CmpItemMenu = { fg = c.bright_magenta, bg = "NONE", italic = true }

          hl.CmpItemKindField = { fg = c.bg, bg = c.red }
          hl.CmpItemKindProperty = { fg = c.bg, bg = c.red }
          hl.CmpItemKindEvent = { fg = c.bg, bg = c.red }

          hl.CmpItemKindText = { fg = c.bg, bg = c.green }
          hl.CmpItemKindEnum = { fg = c.bg, bg = c.green }
          hl.CmpItemKindKeyword = { fg = c.bg, bg = c.green }

          hl.CmpItemKindConstant = { fg = c.bg, bg = c.yellow }
          hl.CmpItemKindConstructor = { fg = c.bg, bg = c.yellow }
          hl.CmpItemKindReference = { fg = c.bg, bg = c.yellow }

          hl.CmpItemKindFunction = { fg = c.bg, bg = c.magenta }
          hl.CmpItemKindStruct = { fg = c.bg, bg = c.magenta }
          hl.CmpItemKindClass = { fg = c.bg, bg = c.magenta }
          hl.CmpItemKindModule = { fg = c.bg, bg = c.magenta }
          hl.CmpItemKindOperator = { fg = c.bg, bg = c.magenta }

          hl.CmpItemKindVariable = { fg = c.bg, bg = c.cyan }
          hl.CmpItemKindFile = { fg = c.bg, bg = c.cyan }

          hl.CmpItemKindUnit = { fg = c.bg, bg = c.orange }
          hl.CmpItemKindSnippet = { fg = c.bg, bg = c.orange }
          hl.CmpItemKindFolder = { fg = c.bg, bg = c.orange }

          hl.CmpItemKindMethod = { fg = c.bg, bg = c.blue }
          hl.CmpItemKindValue = { fg = c.bg, bg = c.blue }
          hl.CmpItemKindEnumMember = { fg = c.bg, bg = c.blue }

          hl.CmpItemKindInterface = { fg = c.bg, bg = c.purple }
          hl.CmpItemKindColor = { fg = c.bg, bg = c.purple }
          hl.CmpItemKindTypeParameter = { fg = c.bg, bg = c.purple }
        end,
        highlight_overrides = {
        },
      })
      vim.cmd([[colorscheme obscure]])
    end,
  },
  {
    "catppuccin/nvim",
    enabled = false,
    name = "catppuccin",
    priority = 1000,
    opts = {},
  },
}
