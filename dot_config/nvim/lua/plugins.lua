return {
  {
    "vim-denops/denops.vim",
    event = "VeryLazy"
  },
  -- {{{ Git
  {
    "lewis6991/gitsigns.nvim",
    event = "CursorHold",
    config = function ()
      require("gitsigns").setup({})
    end
  },
  -- }}}

  -- {{{ Icons
  {
    "nvim-tree/nvim-web-devicons",
    event = "VeryLazy",
    config = function()
      require("nvim-web-devicons").setup({
        override = require("nvim-material-icon").get_icons()
      })
    end,
    dependencies = "DaikyXendo/nvim-material-icon"
  }, -- }}}

  -- {{{ Status, Bufferline
  {
    "tamton-aquib/staline.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons", "nvim-lua/plenary.nvim" },
    config = function()
      local palette = require("catppuccin.palettes.mocha")
      require("staline").setup({
        sections = {
          left = {"- ", "-mode", "left_sep", "file_name"},
          mid = {},
          right = { "lsp_name", "right_sep_double", "-line_column"}
        },
        mode_colors = {
          n = palette.sky,
          i = palette.green,
          c = palette.rosewater,
          v = palette.mauve,
        },
      })
    end,
  },
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    config = function()
      require("bufferline").setup()
    end
  },
  {
    "b0o/incline.nvim",
    enabled = false,
    dependencies = { "nvim-tree/nvim-web-devicons", "SmiteshP/nvim-navic" },
    event = "VeryLazy",
    config = function()
      require('incline').setup({
        window = {
          width = 'fit',
          placement = { horizontal = 'right', vertical = 'top' },
          margin = {
            horizontal = { left = 1, right = 0 },
            vertical = { bottom = 0, top = 1 },
          },
          padding = { left = 1, right = 1 },
          padding_char = ' ',
          winhighlight = {
            Normal = 'NormalFloat',
          },
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
          local icon, color = require('nvim-web-devicons').get_icon_color(filename)
          local nav = {}
          local data = require('nvim-navic').get_data(props.buf)

          for _, v in ipairs(data) do
            table.insert(nav, { '  ' })
            table.insert(nav, {
              v.icon,
              group = 'CmpItemKind' .. v.type,
            })
            table.insert(nav, { v.name })
          end

          return {
            { icon, guifg = color },
            { ' ' },
            { filename },
            nav,
          }
        end,
      })
    end,
  },
  -- }}}

  -- {{{ Colorscheme
  {
    "Allianaab2m/penumbra.nvim",
    enabled = false,
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
  {
    "nyoom-engineering/oxocarbon.nvim",
    enabled = false,
    lazy = false,
    config = function()
      vim.opt.background = "dark"
      vim.cmd.colorscheme "oxocarbon"
      vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#ffffff" })
    end
  },
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    enabled = false,
    config = function ()
      require("nightfox").setup({
        options = {
          dim_inactive = true,
          styles = {
            comments = "italic",
            keywords = "bold",
          }
        }
      })
      vim.cmd.colorscheme "duskfox"
    end
  },
  {
    "marko-cerovac/material.nvim",
    lazy = false,
    enabled = false,
    config = function ()
      vim.g.material_style = "deep ocean"
      require("material").setup({
        contrast = {
          floating_windows = true,
          non_current_windows = true,
        },
        plugins = {
          "nvim-cmp",
          "nvim-web-devicons",
        }
      })

      vim.cmd 'colorscheme material'
    end
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    config = function ()
      require("catppuccin").setup({
        flavor = "mocha",
        transpalent_background = true,
        dim_inactive = {
          enabled = true,
          shade = "dark",
          percentage = 0.15
        },
        custom_highlights = function (C)
          return {
            Folded = { link = "Comment" },
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
          }
        end
      })
      vim.cmd.colorscheme "catppuccin"
      vim.cmd[[ hi DiagnosticUnderlineError  gui=undercurl ]]
      vim.cmd[[ hi DiagnosticUnderlineWarn gui=undercurl ]]
      vim.cmd[[ hi DiagnosticUnderlineInfo gui=undercurl ]]
      vim.cmd[[ hi DiagnosticUnderlineHint gui=undercurl ]]
    end
  },
-- }}}

  -- {{{ Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
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
      "nvim-lua/plenary.nvim",
      "SmiteshP/nvim-navic",
      "yioneko/nvim-vtsls",
    },
    config = function()
      require("mason").setup()
      require("neodev").setup()

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
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

      vim.diagnostic.config({
        float = {
          border = "rounded",
          title = "Diagnostics",
          focusable = false,
          header = {},
          format = function (diag)
            if diag.code then
              return ("[%s](%s): %s"):format(diag.source, diag.code, diag.message)
            else
              return ("[%s]: %s"):format(diag.source, diag.message)
            end
          end
        }
      })

      vim.api.nvim_create_autocmd({"CursorHold"}, {
        pattern = "*",
        callback = function ()
          vim.diagnostic.open_float()
        end
      })

      local signs = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "" },
        { name = "DiagnosticSignInfo", text = "" },
      }

      for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { text_hl = sign.name, numhl = sign.name, text = sign.text })
      end

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
        keymap(bufnr, "n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer = 0, float = false})<CR>", opts)
        keymap(bufnr, "n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer = 0, float = false})<CR>", opts)
        keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
        keymap(bufnr, "n", "<leader>lq", "<cmd>TroubleToggle document_diagnostics<CR>", opts)
      end

      local lsp = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local node_root_dir = lsp.util.root_pattern("package.json")
      local is_node_repo = node_root_dir(vim.api.nvim_buf_get_name(0)) ~= nil

      local server_configs = {
        denols = {
          init_options = {
            lint = true,
            unstable = true,
          },
        },

        tsserver = {
          root_dir = lsp.util.root_pattern("package.json")
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
            local navic = require("nvim-navic")
            if client.server_capabilities.documentSymbolProvider then
              navic.attach(client, bufnr)
            end
            lsp_keymaps(bufnr)
          end

          if name == "tsserver" then
            if not is_node_repo then
              return
            end
            if vim.fn.executable("vtsls") == 1 then
              require("lspconfig.configs").vtsls = require("vtsls").lspconfig
              lsp.vtsls.setup(config)
            end
            return
          elseif name == "denols" then
            if is_node_repo then
              return
            end
          end

          lsp[name].setup(config)
        end
      })

      vim.api.nvim_create_autocmd({ "InsertEnter" }, {
        callback = function()
          vim.diagnostic.config({ virtual_lines = false })
        end
      })
      vim.api.nvim_create_autocmd({ "InsertLeave" }, {
        callback = function()
          vim.diagnostic.config({ virtual_lines = true })
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
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "BufReadPre",
    config = function ()
      local null_ls = require("null-ls")
      local builtins = null_ls.builtins

      null_ls.setup({
        sources = {
          builtins.formatting.eslint_d,
          builtins.diagnostics.textlint.with({ filetypes = { "markdown" } })
        }
      })
    end
  },
  -- }}}

  -- {{{ Skkeleton
  {
    "vim-skk/skkeleton",
    lazy = false,
    dependencies = { "vim-denops/denops.vim" },
    config = function()
      vim.cmd[[
        imap <C-j> <Plug>(skkeleton-enable)
        cmap <C-j> <Plug>(skkeleton-enable)
        call skkeleton#config({
          \ 'globalDictionaries': [
          \   '~/.local/share/fcitx5/skk/user.dict.utf8', 
          \   '~/.local/share/fcitx5/skk/SKK-JISYO.vtuber'],
          \ 'markerHenkan': '▽ ',
          \ 'markerHenkanSelect': '▼ '
          \ })
      ]]
    end
  },
-- }}}

  -- {{{ Comment
  {
    "numToStr/Comment.nvim",
    keys = {
      { "gb", mode = "n" },
      { "gc", mode = "n" }
    },
    config = function ()
      require("Comment").setup()
    end
  },
-- }}}

  -- {{{ cmp
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip",

      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "uga-rosa/cmp-skkeleton",

      "windwp/nvim-autopairs",
      "onsails/lspkind.nvim"
    },
    config = function()
      local has_word_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0
              and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s")
              == nil
      end

      local feedkey = function(key, mode)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
      end

      local cmp = require("cmp")
      local context = require("cmp.config.context")

      cmp.setup({
        enabled = function()
          if vim.api.nvim_get_mode().mode == 'c' then
            return true
          else
            return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
          end
        end,
        window = {
          completion = {
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
            col_offset = -3,
            side_padding = 0
          },
          documentation = cmp.config.window.bordered({ border = "rounded" })
        },
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function (entry, vim_item)
            local kind = require("lspkind").cmp_format({ mode = "symbol_text", max_width = 50})(entry, vim_item)
            local strings = vim.split(kind.kind, "%s", { trimempty = true })
            kind.kind = " " .. strings[1] .. " "
            kind.menu = "    (" .. strings[2] .. ")"

            return kind
          end
        },
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end
        },
        mapping = {
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif vim.fn["vsnip#available"](1) == 1 then
              feedkey("<Plug>(vsnip-expand-or-jump)", "")
            elseif has_word_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function()
            if cmp.visible() then
              cmp.select_prev_item()
            elseif vim.fn["vsnip#jumpable"](-1) == 1 then
              feedkey("<Plug>(vsnip-jump-prev)", "")
            end
          end, { "i", "s" }),
          ["<CR>"] = cmp.mapping.confirm({ select = true })
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "vsnip" },
          { name = "skkeleton" },
          { name = "buffer" }
        })
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
          { name = "cmdline" }
        })
      })

      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        source = cmp.config.sources({
          { name = "buffer" }
        })
      })

      vim.cmd[[highlight Pmenu guibg=NONE]]
    end
  },
  {
    "windwp/nvim-autopairs",
    enabled = false,
    config = function ()
      require("nvim-autopairs").setup()

      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")

      cmp.event:on(
        "confirm_done",
        cmp_autopairs.on_confirm_done()
      )
    end
  },
  {
    "hrsh7th/nvim-minx",
    lazy = false,
    config = function ()
      require("insx.preset.standard").setup()
    end
  },
  -- }}}

  -- {{{ ddc
  {
    "Shougo/ddc.vim",
    enabled = false,
    event = "InsertEnter",
    dependencies = {
      -- Base
      "vim-denops/denops.vim",
      -- UI
      "Shougo/pum.vim",
      "Shougo/ddc-ui-pum",
      -- Source
      "Shougo/ddc-source-around",
      "Shougo/ddc-source-nvim-lsp",
      "hrsh7th/vim-vsnip",
      "hrsh7th/vim-vsnip-integ",
      -- Matcher
      "Shougo/ddc-matcher_head",
      "Shougo/ddc-matcher_length",
      -- Sorter
      "Shougo/ddc-sorter_rank",
      -- Converter
      "Shougo/ddc-converter_remove_overlap",
      "Shougo/ddc-converter_truncate_abbr",
    },
    config = function ()
      vim.cmd[[
        call ddc#custom#patch_global('sources', ['vsnip', 'nvim-lsp', 'around'])

        call ddc#custom#patch_global('sourceOptions', #{
              \ _: #{
              \   matchers: ['matcher_head', 'matcher_length'],
              \   sorters: ['sorter_rank'],
              \   converters: ['converter_remove_overlap', 'converter_truncate_abbr']},
              \ })

        call ddc#custom#patch_global('sourceOptions', #{
              \   around: #{ mark: '[A]' },
              \   nvim-lsp: #{
              \     mark: '[LSP]',
              \     forceCompletionPattern: '\.\w*|:\w*|->\w*|"\w*|\\\w*|\+\w*|\/\w*',
              \     ignoreCase: v:true,
              \     isVolatile: v:true,
              \     dup: 'force',
              \   }, 
              \   vsnip: #{
              \     mark: '[Snip]',
              \     dup: v:false
              \   }
              \ })

        call ddc#custom#patch_global('autoCompleteEvents',
              \ ['InsertEnter', 'TextChangedI', 'TextChangedP', 'TextChangedT'
              \ ])
        call ddc#custom#patch_global('ui', 'pum')

        call pum#set_option('border', 'single')
        call pum#set_option('max_width', 80)
        call pum#set_option('use_complete', v:true)

        autocmd User PumCompleteDone call vsnip_integ#on_complete_done(g:pum#completed_item)

        highlight Pmenu guibg=NONE

        call ddc#enable()
      ]]
      vim.cmd[[
        imap <silent><expr> <TAB> pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' : vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<TAB>'
        imap <silent><expr> <S-TAB> pum#visible() ? '<Cmd>call pum#map#insert_relative(-1)<CR>' : vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-TAB>'
      ]]
    end
  },
  -- }}}

  -- {{{ ddu
  {
    "Shougo/ddu.vim",
    keys = { ";" },
    enabled = false,
    dependencies = {
      "vim-denops/denops.vim",
      -- UI
      "Shougo/ddu-ui-ff",
      "Shougo/ddu-ui-filer",
      -- Source
      "Shougo/ddu-source-file",
      "Shougo/ddu-source-file_rec",
      "shun/ddu-source-buffer",
      -- Filter
      "Milly/ddu-filter-merge",
      "Shougo/ddu-filter-matcher_substring",
      "Milly/ddu-filter-kensaku",
      "kuuote/ddu-filter-fuse",
      -- Column
      "ryota2357/ddu-column-icon_filename",
      -- Kind
      "Shougo/ddu-kind-file",
      "Shougo/ddu-commands.vim",
    },
    config = function ()
      require("denops-lazy").load("ddu")
      vim.cmd [[ source ~/.config/nvim/ddu-conf.vim ]]
      vim.cmd [[ source ~/.config/nvim/ddu-filer-conf.vim ]]
    end
  },
  -- }}}

  -- {{{ Telescope
  {
    "nvim-telescope/telescope.nvim",
    event = { "VeryLazy" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function ()
          require("telescope").load_extension("fzf")
        end
      },
    },
    config = function ()
      local actions = require("telescope.actions")
      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<Esc>"] = actions.close,
            },
            n = {
              ["j"] = actions.move_selection_next,
              ["k"] = actions.move_selection_previous,
              ["q"] = actions.close
            }
          },
          layout_strategy = "horizontal",
          layout_config = { prompt_position = "top" },
          sorting_strategy = "ascending",
          winblend = 0
        },
      })
      vim.keymap.set("n", ";f", "<Cmd>Telescope live_grep<CR>", { noremap = true })
     -- Git
      -- vim.keymap.set("n", ";gc", "<Cmd>Telescope git_commits<CR>", { noremap = true })
      -- vim.keymap.set("n", ";gs", "<Cmd>Telescope git_status<CR>", { noremap = true })
      -- vim.keymap.set("n", ";gb", "<Cmd>Telescope git_branches<CR>", { noremap = true })
      -- LSP
      vim.keymap.set("n", ";ld", "<Cmd>Telescope lsp_document_symbols<CR>", { noremap = true })
    end
  },
  -- }}}

  -- {{{ Noice & UI
    {
      "folke/noice.nvim",
      event = { "BufRead", "BufNewFile", "InsertEnter", "CmdlineEnter" },
      dependencies = {
        { "MunifTanjim/nui.nvim" },
      },
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
          presets = {
            lsp_doc_border = true
          },
          lsp = {
            override = {
              ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
              ["vim.lsp.util.stylize_markdown"] = true,
              ["cmp.entry.get_documentation"] = true
            },
          }
        })
      end
    },
    {
      "luukvbaal/statuscol.nvim",
      lazy = false,
      config = function ()
        require("statuscol").setup({
          setopt = true,
          reeval = true,
          separator = " ",
          order = "sFNsSs",
        })
      end
    },
    {
      "tkmpypy/chowcho.nvim",
      lazy = false,
      config = function ()
        local chowcho = require("chowcho")
        local win_keymap_set = function (key, callback)
          vim.keymap.set({ 'n', 't' }, '<C-w>' .. key, callback)
          vim.keymap.set({ 'n', 't' }, '<C-w><C-' .. key .. '>', callback)
        end

        win_keymap_set('w',
          function ()
            local wins = 0
            for i = 1, vim.fn.winnr('$') do
              local win_id = vim.fn.win_getid(i)
              local conf = vim.api.nvim_win_get_config(win_id)

              if conf.focusable then
                wins = wins + 1
                if wins > 2 then
                  chowcho.run()
                  return
                end
              end
            end

            vim.api.nvim_command("wincmd w")
          end
        )
      end
    },
  -- }}}

  -- {{{ partedit
  {
    "thinca/vim-partedit",
    cmd = "Partedit"
  },
  -- }}}

  -- {{{ Dressing
  {
    "stevearc/dressing.nvim",
    event = "BufReadPre",
    config = function ()
      require("dressing").setup({
        select = {
          builtin = {
            relative = "cursor",
            mappings = {
              ["q"] = "Close",
              ["<CR>"] = "Confirm"
            }
          }
        }
      })
    end
  },
  -- }}}

  -- {{{ Jumpout
  {
    "Allianaab2m/jumpout.vim",
    dev = true, lazy = false,
    config = function ()
    end
  },
  -- }}}

  -- {{{ fuzzy-motion
  {
    "yuki-yano/fuzzy-motion.vim",
    enabled = false,
    dependencies = { "vim-denops/denops.vim", "lambdalisue/kensaku.vim" },
    cmd = { "FuzzyMotion" },
    config = function ()
      require("denops-lazy").load("fuzzy-motion.vim", {})
    end
  },
  {
    "lambdalisue/kensaku.vim",
    lazy = false,
  },
  -- }}}

  -- {{{ utils
  {
    "LeafCage/vimhelpgenerator",
    cmd = { "VimHelpGenerator" }
  },
  { "yuki-yano/denops-lazy.nvim" },
  {
    dir = "~/ghq/github.com/Allianaab2m/vimskey",
    lazy = false,
    dependencies = { "vim-denops/denops.vim" }
  },
  {
    "anuvyklack/pretty-fold.nvim",
    event = "BufReadPre",
    config = function ()
      require('pretty-fold').setup{
      keep_indentation = false,
      fill_char = '━',
      sections = {
          left = {
            '━ ', function() return string.rep('*', vim.v.foldlevel) end, ' ━┫', 'content', '┣'
          },
          right = {
            '┫ ', 'number_of_folded_lines', ': ', 'percentage', ' ┣━━',
          }
        }
      }
    end
  },
  {
    "rhysd/clever-f.vim",
    event = "VeryLazy",
  },
  {
    "unblevable/quick-scope",
    event = "VeryLazy"
  },
  -- }}}

  -- {{{ ToggleTerm
  {
    "akinsho/toggleterm.nvim",
    keys = { ";t" },
    config = function ()
      require("toggleterm").setup({
        direction = "float",
        float_opts = {
          border = "single",
          width = 120,
          height = 20,
          winblend = 3,
        }
      })
      vim.keymap.set("n", ";t", "<Cmd>ToggleTerm<CR>",{ noremap = true })
    end
  },
  -- }}}
 }
-- vim:se fdm=marker:
