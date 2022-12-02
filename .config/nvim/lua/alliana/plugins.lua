require('packer').startup({
  function(use)
    -- base plugins
    use({ 'wbthomason/packer.nvim' })
    use('lewis6991/impatient.nvim')
    use({'DaikyXendo/nvim-material-icon'})
    use({
      'nvim-tree/nvim-web-devicons',
      config = function()
        local material_icon = require("nvim-material-icon")
        require('nvim-web-devicons').setup({
          override = material_icon.get_icons()
        })
      end,
      requires = { 'DaikyXendo/nvim-material-icon' }
    })
    use({'vim-denops/denops.vim'})

    -- Colorscheme
    -- use({
    --   'catppuccin/nvim',
    --   as = 'catppuccin',
    --   config = function()
    --     require('catppuccin').setup({
    --       flavour = 'mocha', -- latte, frappe, macchiato, mocha
    --       background = { -- :h background
    --         light = 'latte',
    --         dark = 'mocha',
    --       },
    --       compile_path = vim.fn.stdpath('cache') .. '/catppuccin',
    --       transparent_background = false,
    --       term_colors = false,
    --       dim_inactive = {
    --         enabled = true,
    --         shade = 'dark',
    --         percentage = 0.10,
    --       },
    --       styles = {
    --         comments = { 'italic' },
    --         conditionals = {},
    --         loops = {},
    --         functions = {},
    --         keywords = {},
    --         strings = {},
    --         variables = {},
    --         numbers = {},
    --         booleans = {},
    --         properties = {},
    --         types = {},
    --         operators = {},
    --       },
    --       color_overrides = {},
    --       custom_highlights = {},
    --       integrations = {
    --         cmp = true,
    --         gitsigns = true,
    --         nvimtree = true,
    --         telescope = true,
    --         treesitter = true,
    --       },
    --     })
    --     vim.api.nvim_command('colorscheme catppuccin')
    --   end,
    -- })

    -- use({
    --   'Allianaab2m/penumbra.nvim',
    --   config = function ()
    --     require('penumbra').setup({
    --       italic_comment = true,
    --       contrast = 'plusplus'
    --     })
    --     vim.api.nvim_command('colorscheme penumbra')
    --   end
    -- })

    use({
      'kvrohit/mellow.nvim',
      config = function ()
        vim.g.mellow_bold_keywords = true

        vim.cmd [[colorscheme mellow]]
      end
    })

    use({
      'norcalli/nvim-colorizer.lua',
      config = function ()
        require('colorizer').setup({
          'css'
        })
      end
    })

    -- Treesitter
    use({
      'JoosepAlviste/nvim-ts-context-commentstring',
      event = 'BufWinEnter',
    })

    use({
      'p00f/nvim-ts-rainbow',
      after = 'nvim-ts-context-commentstring',
    })

    use({
      'nvim-treesitter/nvim-treesitter',
      after = 'nvim-ts-rainbow',
      run = ':TSUpdate',
      config = function()
        require('alliana.treesitter-conf').treesitterSetup()
      end,
    })

    use({
      'nvim-treesitter/playground',
      after = 'nvim-ts-context-commentstring'
    })

    use({
      'nvim-treesitter/nvim-treesitter-context',
      after = 'nvim-treesitter',
      config = function()
        require('alliana.treesitter-conf').contextSetup()
      end,
    })

    use({
      'numToStr/Comment.nvim',
      after = 'nvim-ts-context-commentstring',
      config = function()
        require('Comment').setup({
          pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
        })
      end,
    })

    -- Statusline
    use({
      'tamton-aquib/staline.nvim',
      config = function()
        require('alliana.staline-conf')
      end,
      event = 'BufWinEnter',
    })

    use({
      'akinsho/bufferline.nvim',
      tag = 'v3.*',
      event = 'BufWinEnter',
      config = function()
        require('alliana.bufferline-conf')
      end,
    })

    -- Filetree
    use({
      'nvim-neo-tree/neo-tree.nvim',
      branch = 'v2.x',
      requires = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons',
        'MunifTanjim/nui.nvim',
      },
      cmd = 'NeoTreeFocusToggle',
      config = function()
        require('neo-tree').setup()
      end,
    })

    -- Movement
    use({
      'unblevable/quick-scope',
      setup = function()
        vim.g['qs_highlight_on_keys'] = { 'f', 'F', 't', 'T' }
      end,
      keys = { 'f', 'F', 't', 'T' },
    })

    use({
      'folke/which-key.nvim',
      config = function()
        require('which-key').setup({})
      end,
    })

    -- UI
    use({
      'folke/noice.nvim',
      requires = { 'MunifTanjim/nui.nvim', 'rcarriga/nvim-notify' },
      config = function()
        local function miniView(pattern, kind)
          kind = kind or ''
          return {
            view = 'mini',
            filter = {
              event = 'msg_show',
              kind = kind,
              find = pattern,
            },
          }
        end
        require('noice').setup({
          presets = {
            lsp_doc_border = true,
          },
          popupmenu = {
            backend = 'cmp',
          },
          messages = {
            view_search = 'mini',
          },
          lsp = {
            override = {
              ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
              ['vim.lsp.util.stylize_markdown'] = true,
              ['cmp.entry.get_documentation'] = true,
            },
          },
          routes = {
            {
              view = 'notify',
              filter = { event = 'msg_showmode' },
            },
            {
              filter = {
                event = 'notify',
                warning = true,
                find = 'failed to run generator.*is not executable',
              },
              opts = { skip = true },
            },
            miniView('Already at .* change'),
            miniView('written'),
            miniView('yanked'),
            miniView('more lines?'),
            miniView('fewer lines?'),
            miniView('fewer lines?', 'lua_error'),
            miniView('change; before'),
            miniView('change; after'),
            miniView('line less'),
            miniView('No line in buffer'),
            miniView('search hit .*, continuing at', 'wmsg'),
            miniView('E486: Pattern not found', 'emsg'),
          },
        })
      end,
    })

    use({
      'lukas-reineke/indent-blankline.nvim',
      event = 'BufWinEnter',
      config = function()
        require('indent_blankline').setup({})
      end,
    })

    -- LSP & Completion
    use({
      'neovim/nvim-lspconfig',
      config = function()
        require('alliana.lsp-conf')
      end,
    })
    use({
      'jose-elias-alvarez/null-ls.nvim',
      config = function()
        local null_ls = require('null-ls')
        null_ls.setup({
          sources = {
            null_ls.builtins.formatting.deno_fmt,
            null_ls.builtins.formatting.stylua.with({
              extra_args = { '--config-path /home/alliana/.config/stylua/stylua.toml' },
            }),
            null_ls.builtins.formatting.textlint.with({
              filetypes = { 'markdown' },
            }),
          },
        })
      end,
    })
    use({ 'onsails/lspkind-nvim' })
    use({
      "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
      config = function()
        require("lsp_lines").setup()
        vim.api.nvim_create_autocmd({"InsertEnter"}, {
          callback = function ()
            local state = require("lsp_lines").toggle()
            if state == true then
              require("lsp_lines").toggle()
            end
          end
        })
        vim.api.nvim_create_autocmd({"InsertLeave"}, {
          callback = function ()
            local state = require("lsp_lines").toggle()
            if state == false then
              require("lsp_lines").toggle()
            end
          end
        })
      end,
    })

    use({
      'hrsh7th/nvim-cmp',
      event = 'BufWinEnter',
      config = function()
        require('alliana.cmp-conf')
      end,
    })

    use({ 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' })
    use({ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' })
    use({ 'tzachar/cmp-fuzzy-path', after = 'nvim-cmp', requires = { 'tzachar/fuzzy.nvim' } })
    use({ 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' })
    use({ 'davidsierradz/cmp-conventionalcommits' })
    use({ 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' })
    use({ 'L3MON4D3/LuaSnip', after = 'nvim-cmp' })
    use({ "rinx/cmp-skkeleton", after = { "nvim-cmp", "skkeleton" }})

    use({
      'williamboman/mason.nvim',
      config = function()
        require('mason').setup()
      end,
    })
    use({ 'williamboman/mason-lspconfig.nvim' })

    use({ 'SmiteshP/nvim-navic', requires = { 'nvim-lspconfig' } })

    use({
      'windwp/nvim-autopairs',
      after = 'nvim-cmp',
      config = function()
        local cmp_ap = require('nvim-autopairs.completion.cmp')
        local cmp = require('cmp')
        cmp.event:on('confirm_done', cmp_ap.on_confirm_done())

        require('nvim-autopairs').setup({})
      end,
    })

    use({"vim-skk/skkeleton", requires = { "vim-denops/denops.vim" }})

    use({
      "simrat39/rust-tools.nvim",
      config = function ()
        local rt = require("rust-tools")
        rt.setup({
          server = {
            on_attach = function (_, bufnr)
              vim.keymap.set("n", "<C-Space>", rt.hover_actions.hover_actions, { buffer = bufnr })
              vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
            end
          }
        })
      end
    })

    use({
      "iamcco/markdown-preview.nvim",
      run = function ()
        vim.fn["mkdp#util#install"]()
      end
    })

    use({
      'ldelossa/nvim-ide',
      config = function ()
        -- default components
        local explorer        = require('ide.components.explorer')
        local outline         = require('ide.components.outline')
        local callhierarchy   = require('ide.components.callhierarchy')
        local timeline        = require('ide.components.timeline')
        local terminal        = require('ide.components.terminal')
        local terminalbrowser = require('ide.components.terminal.terminalbrowser')
        local changes         = require('ide.components.changes')
        local commits         = require('ide.components.commits')
        local branches        = require('ide.components.branches')
        local bookmarks       = require('ide.components.bookmarks')
        local bufferlist      = require('ide.components.bufferlist')

        require('ide').setup({
            -- The global icon set to use.
            -- values: "nerd", "codicon", "default"
            icon_set = "default",
            -- Component specific configurations and default config overrides.
            components = {
                -- The global keymap is applied to all Components before construction.
                -- It allows common keymaps such as "hide" to be overriden, without having
                -- to make an override entry for all Components.
                --
                -- If a more specific keymap override is defined for a specific Component
                -- this takes precedence.
                global_keymaps = {
                    -- example, change all Component's hide keymap to "h"
                    hide = "h"
                },

                -- example, prefer "x" for hide only for Explorer component.
                -- Explorer = {
                --     keymaps = {
                --         hide = "x",
                --     }
                -- }
            },
            -- default panel groups to display on left and right.
            panels = {
                left = "explorer",
                right = "git",
            },
            -- panels defined by groups of components, user is free to redefine the defaults
            -- and/or add additional.
            panel_groups = {
                explorer = { explorer.Name, bookmarks.Name, callhierarchy.Name, outline.Name },
                terminal = { terminal.Name },
                git = { changes.Name, commits.Name, timeline.Name, branches.Name },
            },
            -- workspaces config
            workspaces = {
                -- which panels to open by default, one of: 'left', 'right', 'both', 'none'
                auto_open = 'both',
            },
            -- default panel sizes for the different positions
            panel_sizes = {
                left = 30,
                right = 30,
                bottom = 15
            }
        })
      end
    })
  end,

  config = {
    display = {
      open_fn = require('packer.util').float,
    },
  },
})
