return {
  "vim-denops/denops.vim",

  -- {{{ Icons
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup({
        override = require("nvim-material-icon").get_icons()
      })
    end,
    dependencies = {
      "DaikeyXendo/nvim-material-icon"
    }
  }, -- }}}

  -- {{{ Statusline
  {
    "tamton-aquib/staline.nvim",
    lazy = false,
    config = function()
      require("staline").setup()
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" }
  }, -- }}}

-- {{{ Colorscheme
  {
    "Allianaab2m/penumbra.nvim",
    lazy = false,
    config = function()
      require("penumbra").setup({
        italic_comment = true,
        show_end_of_buffer = true,
        contrast = "plusplus",
      })
      vim.api.nvim_command("colorscheme penumbra")
    end
  },
-- }}}

  -- {{{ Filetree
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    config = function()
      vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1]])
      require("neotree").setup({
        filesystem = {
          follow_current_file = true,
          hijack_netrw_behavior = "open_current",
        }
      })
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim"
    }
  }, -- }}}

  -- {{{ Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    event = "BufReadPost",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        highlight = {
          enable = true,
        },
        ensure_installed = {
          "javascript",
          "typescript",
          "lua",
          "json",
          "jsdoc",
          "tsx",
          "markdown",
          "rust"
        },
        context_commentstring = {
          enable = true
        },
      })
    end,
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
      "p00f/nvim-ts-rainbow",
      {
        "nvim-treesitter/nvim-treesitter-context",
        config = function()
          require("treesitter-context").setup({})
        end
      }
    },
  }, -- }}}

  -- {{{ LSP
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      "folke/neodev.nvim",
      "williamboman/mason-lspconfig.nvim",
      "williamboman/mason.nvim",
      "folke/lsp-colors.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("mason").setup()
      vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
          underline = true,
          signs = {},
          virtual_text = false,
          severity_sort = true,
          float = {
            focusable = true,
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
          }
        }
      )

      vim.diagnostic.config({
        float = { border = "rounded" }
      })

      require("neodev").setup()

      local function lsp_keymaps(bufnr)
        local opts = { noremap = true, silent = true }
        local keymap = vim.api.nvim_buf_set_keymap
        keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
        keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
        keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
        keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
        keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
        keymap(bufnr, "n", "gl", "<cmd>lua vim.lsp.diagnostic.open_float()<CR>", opts)
        keymap(bufnr, "n", "<leader>lf", "<cmd>lua vim.lsp.buf.format { async = true }<CR>", opts)
        keymap(bufnr, "n", "<leader>li", "<cmd>LspInfo<CR>", opts)
        keymap(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
        keymap(bufnr, "n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer = 0})<CR>", opts)
        keymap(bufnr, "n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer = 0})<CR>", opts)
        keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
        keymap(bufnr, "n", "<leader>lq", "<cmd>TroubleToggle document_diagnostics<CR>", opts)
      end

      local lsp = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

      local server_configs = {
        denols = {
          init_options = {
            lint = true,
            unstable = true,
          }
        },

        sumneko_lua = {
          settings = {
            Lua = {
              completion = {
                callSnippet = "Replace"
              },
            }
          }
        },
      }

      require("mason-lspconfig").setup_handlers({
        function(name)
          local config = server_configs[name] or {}
          config.capabilities = capabilities
          config.on_attach = function(client, bufnr)
            lsp_keymaps(bufnr)
          end
          lsp[name].setup(config)
        end
      })
    end
  },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
    config = function()
      require("trouble").setup()
    end
  },
  -- }}}

  -- {{{ cmp
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      { "hrsh7th/cmp-nvim-lua", ft = "lua" },
      { "onsails/lspkind-nvim" },
      { "hrsh7th/cmp-nvim-lsp", event = "InsertEnter" },
      { "saadparwaiz1/cmp_luasnip",
        dependencies = {
          {
            "L3MON4D3/LuaSnip",
            dependencies = {
              "rafamadriz/friendly-snippets",
            },
            config = function()
              require("luasnip.loaders.from_vscode").lazy_load()
            end
          }
        }
      },
      {
        "windwp/nvim-autopairs",
        config = function ()
          require("nvim-autopairs").setup()
        end
      },
    },
    config = function()
      vim.o.completeopt = "menuone,noselect"
      local lspkind_format = require("lspkind").cmp_format({
        mode = "symbol_text",
        maxwidth = 50,
        menu = {
          nvim_lsp = "[L]",
          nvim_lua = "[LU]",
          luasnip = "[S]",
        },
      })

      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0
            and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s")
            == nil
      end

      cmp.setup({
        completion = {
          completeopt = "menu,menuone,noselect"
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end
        },
        formatting = {
          format = lspkind_format
        },
        mapping = {
          ["<CR>"] = cmp.mapping.confirm { select = false },
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" })
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        sources = cmp.config.sources(
          { { name = "nvim_lsp" } },
          { { name = "luasnip" } }
        ),
        experimental = {
          ghost_text = true,
        }
      })

      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

      vim.cmd("highlight Pmenu guibg=NONE")
    end,
  },
  -- }}}

-- {{{ Telescope
{
},
-- }}}

  -- {{{ Noice
    {
      "folke/noice.nvim",
      event = { "BufRead", "BufNewFile", "InsertEnter", "CmdlineEnter" },
      dependencies = {
        { "MunifTanjim/nui.nvim" },
        {
          "rcarriga/nvim-notify",
          config = function()
            require("notify").setup()
          end
        }
      },
      init = function()
        if not _G.__vim_notify_overwritten then
          vim.notify = function(...)
            local arg = { ... }
            require("notify")
            require("noice")
            vim.schedule(function ()
              vim.notify(unpack(args))
            end)
          end
          _G.__vim_notify_overwritten = true
        end
      end,
      config = function ()
        local focused = true
        vim.api.nvim_create_autocmd("FocusGained", {
          callback = function ()
            focused = true
          end,
        })
        vim.api.nvim_create_autocmd("FocusLost", {
          callback = function ()
            focused = false
          end,
        })

        require("noice").setup({
          lsp = {
            override = {
              ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
              ["vim.lsp.util.stylize_markdown"] = true,
              ["cmp.entry.get_documentation"] = true
            }
          }
        })
      end
    }
  -- }}}
}
-- vim:se fdm=marker:
