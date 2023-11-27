return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "Allianaab2m/telescope-kensaku.nvim",
        dependencies = {
          "lambdalisue/kensaku.vim",
        },
        config = function()
          require("telescope").load_extension("kensaku")
        end,
      },
      "nvim-telescope/telescope-file-browser.nvim",
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      telescope.setup({
        defaults = {
          mappings = {
            i = {
              ["<Esc>"] = actions.close,
            },
            n = {
              ["q"] = function(...)
                actions.close(...)
              end,
            },
          },
          layout_strategy = "vertical",
          layout_config = { prompt_position = "bottom" },
          sorting_strategy = "ascending",
          winblend = 0,
          borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        },
        extensions = {
          file_browser = {
            layout_strategy = "horizontal",
          },
        },
      })

      require("telescope").load_extension("file_browser")

      local key = vim.keymap.set
      local opts = { noremap = true, silent = true }

      key("n", ";;", "<Cmd>Telescope<CR>", opts)
      key("n", ";f", "<Cmd>Telescope find_files<CR>", opts)
      key("n", ";d", "<Cmd>Telescope file_browser<CR>", opts)
      --key("n", ";lg", "<Cmd>Telescope kensaku<CR>", opts)
      key("n", ";gs", "<Cmd>Telescope git_status<CR>", opts)
      key("n", ";gb", "<Cmd>Telescope git_branches<CR>", opts)
      key("n", ";b", "<Cmd>Telescope buffers<CR>", opts)
    end,
  },
  {
    "nvim-telescope/telescope-frecency.nvim",
    lazy = false,
    config = function()
      require("telescope").load_extension("frecency")
    end,
  },
}
