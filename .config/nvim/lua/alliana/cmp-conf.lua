vim.o.completeopt = "menu,menuone,noselect"

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0
             and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s")
             == nil
end

local cmp = require('cmp')
local luasnip = require('luasnip')
local lspkind = require('lspkind')

cmp.setup({
  enabled = function()
    -- disable completion in comments
    local context = require 'cmp.config.context'
    -- keep command mode completion enabled when cursor is in a comment
    if vim.api.nvim_get_mode().mode == 'c' then
      return true
    else
      return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
    end
  end,
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered()
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
  formatting = {
    fields = { 'kind', 'abbr', 'menu' },
    format = lspkind.cmp_format({
      with_text = true,
      maxwidth = 50,
      menu = {nvim_lsp = "[ ]", luasnip = "[Snip]"}
    }),
  },
  mapping = {
    ['<C-d>'] = require('noice.lsp').scroll(-4),
    ['<C-f>'] = require('noice.lsp').scroll(4),
    ['<C-o>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({select = true}),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      end
    end, {"i", "s"}),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {"i", "s"})
  },
  sources = cmp.config.sources(
    {{ name = 'nvim_lsp' }},
    {{ name = 'luasnip' }},
    {{ name = 'fuzzy_path' }},
    {{ name = 'conventionalcommits' }}
  ),
  experimental = {
    ghost_text = true
  }
})

cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'cmdline' },
    { name = 'buffer' },
    { name = 'fuzzy_path', option = {fd_timeout_msec = 1500}}
  }),
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-o>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({select = true}),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      end
    end, {"i", "s"}),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {"i", "s"})
  },
})

vim.cmd("highlight Pmenu guibg=NONE")
