-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/alliana/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/alliana/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/alliana/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/alliana/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/alliana/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    config = { "\27LJ\2\n \1\0\0\6\0\a\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\5\0006\3\0\0'\5\3\0B\3\2\0029\3\4\3B\3\1\2=\3\6\2B\0\2\1K\0\1\0\rpre_hook\1\0\0\20create_pre_hook7ts_context_commentstring.integrations.comment_nvim\nsetup\fComment\frequire\0" },
    load_after = {
      ["nvim-ts-context-commentstring"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/alliana/.local/share/nvim/site/pack/packer/opt/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  LuaSnip = {
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = true,
    path = "/home/alliana/.local/share/nvim/site/pack/packer/opt/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["bufferline.nvim"] = {
    config = { "\27LJ\2\n7\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\28alliana.bufferline-conf\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/alliana/.local/share/nvim/site/pack/packer/opt/bufferline.nvim",
    url = "https://github.com/akinsho/bufferline.nvim"
  },
  ["cmp-cmdline"] = {
    after_files = { "/home/alliana/.local/share/nvim/site/pack/packer/opt/cmp-cmdline/after/plugin/cmp_cmdline.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/alliana/.local/share/nvim/site/pack/packer/opt/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-conventionalcommits"] = {
    loaded = true,
    path = "/home/alliana/.local/share/nvim/site/pack/packer/start/cmp-conventionalcommits",
    url = "https://github.com/davidsierradz/cmp-conventionalcommits"
  },
  ["cmp-fuzzy-path"] = {
    after_files = { "/home/alliana/.local/share/nvim/site/pack/packer/opt/cmp-fuzzy-path/after/plugin/cmp_fuzzy_path.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/alliana/.local/share/nvim/site/pack/packer/opt/cmp-fuzzy-path",
    url = "https://github.com/tzachar/cmp-fuzzy-path"
  },
  ["cmp-nvim-lsp"] = {
    after_files = { "/home/alliana/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp/after/plugin/cmp_nvim_lsp.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/alliana/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  cmp_luasnip = {
    after_files = { "/home/alliana/.local/share/nvim/site/pack/packer/opt/cmp_luasnip/after/plugin/cmp_luasnip.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/alliana/.local/share/nvim/site/pack/packer/opt/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["denops.vim"] = {
    loaded = true,
    path = "/home/alliana/.local/share/nvim/site/pack/packer/start/denops.vim",
    url = "https://github.com/vim-denops/denops.vim"
  },
  ["fuzzy.nvim"] = {
    loaded = true,
    path = "/home/alliana/.local/share/nvim/site/pack/packer/start/fuzzy.nvim",
    url = "https://github.com/tzachar/fuzzy.nvim"
  },
  ["impatient.nvim"] = {
    loaded = true,
    path = "/home/alliana/.local/share/nvim/site/pack/packer/start/impatient.nvim",
    url = "https://github.com/lewis6991/impatient.nvim"
  },
  ["indent-blankline.nvim"] = {
    config = { "\27LJ\2\nB\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\21indent_blankline\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/alliana/.local/share/nvim/site/pack/packer/opt/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/home/alliana/.local/share/nvim/site/pack/packer/start/lspkind-nvim",
    url = "https://github.com/onsails/lspkind-nvim"
  },
  ["markdown-preview.nvim"] = {
    loaded = true,
    path = "/home/alliana/.local/share/nvim/site/pack/packer/start/markdown-preview.nvim",
    url = "https://github.com/iamcco/markdown-preview.nvim"
  },
  ["mason-lspconfig.nvim"] = {
    loaded = true,
    path = "/home/alliana/.local/share/nvim/site/pack/packer/start/mason-lspconfig.nvim",
    url = "https://github.com/williamboman/mason-lspconfig.nvim"
  },
  ["mason.nvim"] = {
    config = { "\27LJ\2\n3\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\nmason\frequire\0" },
    loaded = true,
    path = "/home/alliana/.local/share/nvim/site/pack/packer/start/mason.nvim",
    url = "https://github.com/williamboman/mason.nvim"
  },
  ["neo-tree.nvim"] = {
    commands = { "NeoTreeFocusToggle" },
    config = { "\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rneo-tree\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/alliana/.local/share/nvim/site/pack/packer/opt/neo-tree.nvim",
    url = "https://github.com/nvim-neo-tree/neo-tree.nvim"
  },
  ["noice.nvim"] = {
    config = { "\27LJ\2\n\\\0\2\4\0\6\0\t\14\0\1\0X\2\1€'\1\0\0005\2\1\0005\3\2\0=\1\3\3=\0\4\3=\3\5\2L\2\2\0\vfilter\tfind\tkind\1\0\1\nevent\rmsg_show\1\0\1\tview\tmini\5ƒ\a\1\0\t\0%\1Q3\0\0\0006\1\1\0'\3\2\0B\1\2\0029\1\3\0015\3\5\0005\4\4\0=\4\6\0035\4\a\0=\4\b\0035\4\t\0=\4\n\0035\4\f\0005\5\v\0=\5\r\4=\4\14\0034\4\15\0005\5\15\0005\6\16\0=\6\17\5>\5\1\0045\5\19\0005\6\18\0=\6\17\0055\6\20\0=\6\21\5>\5\2\4\18\5\0\0'\a\22\0B\5\2\2>\5\3\4\18\5\0\0'\a\23\0B\5\2\2>\5\4\4\18\5\0\0'\a\24\0B\5\2\2>\5\5\4\18\5\0\0'\a\25\0B\5\2\2>\5\6\4\18\5\0\0'\a\26\0B\5\2\2>\5\a\4\18\5\0\0'\a\26\0'\b\27\0B\5\3\2>\5\b\4\18\5\0\0'\a\28\0B\5\2\2>\5\t\4\18\5\0\0'\a\29\0B\5\2\2>\5\n\4\18\5\0\0'\a\30\0B\5\2\2>\5\v\4\18\5\0\0'\a\31\0B\5\2\2>\5\f\4\18\5\0\0'\a \0'\b!\0B\5\3\2>\5\r\4\18\5\0\0'\a\"\0'\b#\0B\5\3\0?\5\0\0=\4$\3B\1\2\1K\0\1\0\vroutes\temsg\28E486: Pattern not found\twmsg!search hit .*, continuing at\22No line in buffer\14line less\18change; after\19change; before\14lua_error\17fewer lines?\16more lines?\vyanked\fwritten\25Already at .* change\topts\1\0\1\tskip\2\1\0\0\1\0\3\tfind/failed to run generator.*is not executable\fwarning\2\nevent\vnotify\vfilter\1\0\1\nevent\17msg_showmode\1\0\1\tview\vnotify\blsp\roverride\1\0\0\1\0\3 cmp.entry.get_documentation\2\"vim.lsp.util.stylize_markdown\0021vim.lsp.util.convert_input_to_markdown_lines\2\rmessages\1\0\1\16view_search\tmini\14popupmenu\1\0\1\fbackend\bcmp\fpresets\1\0\0\1\0\1\19lsp_doc_border\2\nsetup\nnoice\frequire\0\29€€À™\4\0" },
    loaded = true,
    path = "/home/alliana/.local/share/nvim/site/pack/packer/start/noice.nvim",
    url = "https://github.com/folke/noice.nvim"
  },
  ["nui.nvim"] = {
    loaded = true,
    path = "/home/alliana/.local/share/nvim/site/pack/packer/start/nui.nvim",
    url = "https://github.com/MunifTanjim/nui.nvim"
  },
  ["null-ls.nvim"] = {
    config = { "\27LJ\2\n¿\2\0\0\t\0\17\1\0316\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\15\0004\4\4\0009\5\3\0009\5\4\0059\5\5\5>\5\1\0049\5\3\0009\5\4\0059\5\6\0059\5\a\0055\a\t\0005\b\b\0=\b\n\aB\5\2\2>\5\2\0049\5\3\0009\5\4\0059\5\v\0059\5\a\0055\a\r\0005\b\f\0=\b\14\aB\5\2\0?\5\0\0=\4\16\3B\1\2\1K\0\1\0\fsources\1\0\0\14filetypes\1\0\0\1\2\0\0\rmarkdown\rtextlint\15extra_args\1\0\0\1\2\0\0;--config-path /home/alliana/.config/stylua/stylua.toml\twith\vstylua\rdeno_fmt\15formatting\rbuiltins\nsetup\fnull-ls\frequire\a€€À™\4\0" },
    loaded = true,
    path = "/home/alliana/.local/share/nvim/site/pack/packer/start/null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\n¼\1\0\0\b\0\t\0\0206\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\2\3\1\18\4\2\0009\2\4\2'\5\5\0009\6\6\0B\6\1\0A\2\2\0016\2\0\0'\4\a\0B\2\2\0029\2\b\0024\4\0\0B\2\2\1K\0\1\0\nsetup\19nvim-autopairs\20on_confirm_done\17confirm_done\aon\nevent\bcmp\"nvim-autopairs.completion.cmp\frequire\0" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/alliana/.local/share/nvim/site/pack/packer/opt/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    after = { "LuaSnip", "cmp-nvim-lsp", "cmp_luasnip", "cmp-fuzzy-path", "nvim-autopairs", "cmp-cmdline" },
    config = { "\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\21alliana.cmp-conf\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/alliana/.local/share/nvim/site/pack/packer/opt/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\2\nC\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\2\0\0\bcss\nsetup\14colorizer\frequire\0" },
    loaded = true,
    path = "/home/alliana/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua",
    url = "https://github.com/norcalli/nvim-colorizer.lua"
  },
  ["nvim-lspconfig"] = {
    config = { "\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\21alliana.lsp-conf\frequire\0" },
    loaded = true,
    path = "/home/alliana/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-navic"] = {
    loaded = true,
    path = "/home/alliana/.local/share/nvim/site/pack/packer/start/nvim-navic",
    url = "https://github.com/SmiteshP/nvim-navic"
  },
  ["nvim-notify"] = {
    loaded = true,
    path = "/home/alliana/.local/share/nvim/site/pack/packer/start/nvim-notify",
    url = "https://github.com/rcarriga/nvim-notify"
  },
  ["nvim-treesitter"] = {
    after = { "nvim-treesitter-context" },
    config = { "\27LJ\2\nO\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\20treesitterSetup\28alliana.treesitter-conf\frequire\0" },
    load_after = {
      ["nvim-ts-rainbow"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/alliana/.local/share/nvim/site/pack/packer/opt/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-context"] = {
    config = { "\27LJ\2\nL\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\17contextSetup\28alliana.treesitter-conf\frequire\0" },
    load_after = {
      ["nvim-treesitter"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/alliana/.local/share/nvim/site/pack/packer/opt/nvim-treesitter-context",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-context"
  },
  ["nvim-ts-context-commentstring"] = {
    after = { "Comment.nvim", "nvim-ts-rainbow", "playground" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/alliana/.local/share/nvim/site/pack/packer/opt/nvim-ts-context-commentstring",
    url = "https://github.com/JoosepAlviste/nvim-ts-context-commentstring"
  },
  ["nvim-ts-rainbow"] = {
    after = { "nvim-treesitter" },
    load_after = {
      ["nvim-ts-context-commentstring"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/alliana/.local/share/nvim/site/pack/packer/opt/nvim-ts-rainbow",
    url = "https://github.com/p00f/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    config = { "\27LJ\2\n¤\1\0\0\5\0\n\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\b\0005\3\4\0005\4\3\0=\4\5\0035\4\6\0=\4\a\3=\3\t\2B\0\2\1K\0\1\0\roverride\1\0\0\ajs\1\0\2\ncolor\f#F1DD35\ticon\bï \ats\1\0\0\1\0\2\ncolor\f#3178C6\ticon\bï¯¤\nsetup\22nvim-web-devicons\frequire\0" },
    loaded = true,
    path = "/home/alliana/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/nvim-tree/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/alliana/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["penumbra.nvim"] = {
    config = { "\27LJ\2\n\1\0\0\3\0\b\0\f6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\4\0009\0\5\0009\0\6\0'\2\a\0B\0\2\1K\0\1\0\25colorscheme penumbra\17nvim_command\bapi\bvim\1\0\2\19italic_comment\2\rcontrast\rplusplus\nsetup\rpenumbra\frequire\0" },
    loaded = true,
    path = "/home/alliana/.local/share/nvim/site/pack/packer/start/penumbra.nvim",
    url = "https://github.com/Allianaab2m/penumbra.nvim"
  },
  playground = {
    load_after = {
      ["nvim-ts-context-commentstring"] = true
    },
    loaded = false,
    needs_bufread = true,
    path = "/home/alliana/.local/share/nvim/site/pack/packer/opt/playground",
    url = "https://github.com/nvim-treesitter/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/alliana/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["quick-scope"] = {
    keys = { { "", "f" }, { "", "F" }, { "", "t" }, { "", "T" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/alliana/.local/share/nvim/site/pack/packer/opt/quick-scope",
    url = "https://github.com/unblevable/quick-scope"
  },
  ["staline.nvim"] = {
    config = { "\27LJ\2\n4\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\25alliana.staline-conf\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/alliana/.local/share/nvim/site/pack/packer/opt/staline.nvim",
    url = "https://github.com/tamton-aquib/staline.nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/home/alliana/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["which-key.nvim"] = {
    config = { "\27LJ\2\n;\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\14which-key\frequire\0" },
    loaded = true,
    path = "/home/alliana/.local/share/nvim/site/pack/packer/start/which-key.nvim",
    url = "https://github.com/folke/which-key.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Setup for: quick-scope
time([[Setup for quick-scope]], true)
try_loadstring("\27LJ\2\nB\0\0\2\0\4\0\0056\0\0\0009\0\1\0005\1\3\0=\1\2\0K\0\1\0\1\5\0\0\6f\6F\6t\6T\25qs_highlight_on_keys\6g\bvim\0", "setup", "quick-scope")
time([[Setup for quick-scope]], false)
-- Config for: which-key.nvim
time([[Config for which-key.nvim]], true)
try_loadstring("\27LJ\2\n;\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\14which-key\frequire\0", "config", "which-key.nvim")
time([[Config for which-key.nvim]], false)
-- Config for: nvim-web-devicons
time([[Config for nvim-web-devicons]], true)
try_loadstring("\27LJ\2\n¤\1\0\0\5\0\n\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\b\0005\3\4\0005\4\3\0=\4\5\0035\4\6\0=\4\a\3=\3\t\2B\0\2\1K\0\1\0\roverride\1\0\0\ajs\1\0\2\ncolor\f#F1DD35\ticon\bï \ats\1\0\0\1\0\2\ncolor\f#3178C6\ticon\bï¯¤\nsetup\22nvim-web-devicons\frequire\0", "config", "nvim-web-devicons")
time([[Config for nvim-web-devicons]], false)
-- Config for: mason.nvim
time([[Config for mason.nvim]], true)
try_loadstring("\27LJ\2\n3\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\nmason\frequire\0", "config", "mason.nvim")
time([[Config for mason.nvim]], false)
-- Config for: null-ls.nvim
time([[Config for null-ls.nvim]], true)
try_loadstring("\27LJ\2\n¿\2\0\0\t\0\17\1\0316\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\15\0004\4\4\0009\5\3\0009\5\4\0059\5\5\5>\5\1\0049\5\3\0009\5\4\0059\5\6\0059\5\a\0055\a\t\0005\b\b\0=\b\n\aB\5\2\2>\5\2\0049\5\3\0009\5\4\0059\5\v\0059\5\a\0055\a\r\0005\b\f\0=\b\14\aB\5\2\0?\5\0\0=\4\16\3B\1\2\1K\0\1\0\fsources\1\0\0\14filetypes\1\0\0\1\2\0\0\rmarkdown\rtextlint\15extra_args\1\0\0\1\2\0\0;--config-path /home/alliana/.config/stylua/stylua.toml\twith\vstylua\rdeno_fmt\15formatting\rbuiltins\nsetup\fnull-ls\frequire\a€€À™\4\0", "config", "null-ls.nvim")
time([[Config for null-ls.nvim]], false)
-- Config for: penumbra.nvim
time([[Config for penumbra.nvim]], true)
try_loadstring("\27LJ\2\n\1\0\0\3\0\b\0\f6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\4\0009\0\5\0009\0\6\0'\2\a\0B\0\2\1K\0\1\0\25colorscheme penumbra\17nvim_command\bapi\bvim\1\0\2\19italic_comment\2\rcontrast\rplusplus\nsetup\rpenumbra\frequire\0", "config", "penumbra.nvim")
time([[Config for penumbra.nvim]], false)
-- Config for: nvim-lspconfig
time([[Config for nvim-lspconfig]], true)
try_loadstring("\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\21alliana.lsp-conf\frequire\0", "config", "nvim-lspconfig")
time([[Config for nvim-lspconfig]], false)
-- Config for: nvim-colorizer.lua
time([[Config for nvim-colorizer.lua]], true)
try_loadstring("\27LJ\2\nC\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\2\0\0\bcss\nsetup\14colorizer\frequire\0", "config", "nvim-colorizer.lua")
time([[Config for nvim-colorizer.lua]], false)
-- Config for: noice.nvim
time([[Config for noice.nvim]], true)
try_loadstring("\27LJ\2\n\\\0\2\4\0\6\0\t\14\0\1\0X\2\1€'\1\0\0005\2\1\0005\3\2\0=\1\3\3=\0\4\3=\3\5\2L\2\2\0\vfilter\tfind\tkind\1\0\1\nevent\rmsg_show\1\0\1\tview\tmini\5ƒ\a\1\0\t\0%\1Q3\0\0\0006\1\1\0'\3\2\0B\1\2\0029\1\3\0015\3\5\0005\4\4\0=\4\6\0035\4\a\0=\4\b\0035\4\t\0=\4\n\0035\4\f\0005\5\v\0=\5\r\4=\4\14\0034\4\15\0005\5\15\0005\6\16\0=\6\17\5>\5\1\0045\5\19\0005\6\18\0=\6\17\0055\6\20\0=\6\21\5>\5\2\4\18\5\0\0'\a\22\0B\5\2\2>\5\3\4\18\5\0\0'\a\23\0B\5\2\2>\5\4\4\18\5\0\0'\a\24\0B\5\2\2>\5\5\4\18\5\0\0'\a\25\0B\5\2\2>\5\6\4\18\5\0\0'\a\26\0B\5\2\2>\5\a\4\18\5\0\0'\a\26\0'\b\27\0B\5\3\2>\5\b\4\18\5\0\0'\a\28\0B\5\2\2>\5\t\4\18\5\0\0'\a\29\0B\5\2\2>\5\n\4\18\5\0\0'\a\30\0B\5\2\2>\5\v\4\18\5\0\0'\a\31\0B\5\2\2>\5\f\4\18\5\0\0'\a \0'\b!\0B\5\3\2>\5\r\4\18\5\0\0'\a\"\0'\b#\0B\5\3\0?\5\0\0=\4$\3B\1\2\1K\0\1\0\vroutes\temsg\28E486: Pattern not found\twmsg!search hit .*, continuing at\22No line in buffer\14line less\18change; after\19change; before\14lua_error\17fewer lines?\16more lines?\vyanked\fwritten\25Already at .* change\topts\1\0\1\tskip\2\1\0\0\1\0\3\tfind/failed to run generator.*is not executable\fwarning\2\nevent\vnotify\vfilter\1\0\1\nevent\17msg_showmode\1\0\1\tview\vnotify\blsp\roverride\1\0\0\1\0\3 cmp.entry.get_documentation\2\"vim.lsp.util.stylize_markdown\0021vim.lsp.util.convert_input_to_markdown_lines\2\rmessages\1\0\1\16view_search\tmini\14popupmenu\1\0\1\fbackend\bcmp\fpresets\1\0\0\1\0\1\19lsp_doc_border\2\nsetup\nnoice\frequire\0\29€€À™\4\0", "config", "noice.nvim")
time([[Config for noice.nvim]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file NeoTreeFocusToggle lua require("packer.load")({'neo-tree.nvim'}, { cmd = "NeoTreeFocusToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

-- Keymap lazy-loads
time([[Defining lazy-load keymaps]], true)
vim.cmd [[noremap <silent> T <cmd>lua require("packer.load")({'quick-scope'}, { keys = "T", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> F <cmd>lua require("packer.load")({'quick-scope'}, { keys = "F", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> t <cmd>lua require("packer.load")({'quick-scope'}, { keys = "t", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> f <cmd>lua require("packer.load")({'quick-scope'}, { keys = "f", prefix = "" }, _G.packer_plugins)<cr>]]
time([[Defining lazy-load keymaps]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au BufWinEnter * ++once lua require("packer.load")({'nvim-ts-context-commentstring', 'bufferline.nvim', 'nvim-cmp', 'staline.nvim', 'indent-blankline.nvim'}, { event = "BufWinEnter *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
