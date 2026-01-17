--@type LazySpec
return {
  "saghen/blink.cmp",
  cond = not is_vscode(),
  event = "VeryLazy",
  dependencies = { "rafamadriz/friendly-snippets", "xzbdmw/colorful-menu.nvim" },

  version = "1.*",

  opts = {
    keymap = { preset = "super-tab" },

    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },

    completion = {
      ghost_text = { enabled = true },
      documentation = { auto_show = true },
      list = {
        selection = {
          preselect = function(ctx)
            return not require("blink.cmp").snippet_active({ direction = 1 })
          end,
          auto_insert = true
        }
      },
      menu = {
        draw = {
          columns = { { "kind_icon" }, { "label", gap = 1 } },
          components = {
            label = {
              text = function(ctx)
                return require("colorful-menu").blink_components_text(ctx)
              end,
              highlight = function(ctx)
                return require("colorful-menu").blink_components_highlight(ctx)
              end,
            }
          }
        }
      }
    }
  },
  opts_extend = { "sources.default" }
}
