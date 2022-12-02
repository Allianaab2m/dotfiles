local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local signs = {
  { name = 'DiagnosticSignError' },
  { name = 'DiagnosticSignWarn' },
  { name = 'DiagnosticSignHint' },
  { name = 'DiagnosticSignInfo' },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, numhl = sign.name })
end

local config = {
  virtual_text = false,
  signs = {},
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = true,
    style = 'minimal',
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
}

local lsp_formatting = function (bufnr)
  vim.lsp.buf.format({
    filter = function (client)
      return client.name == 'null-ls'
    end,
    bufnr = bufnr
  })
end

local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  local keymap = vim.api.nvim_buf_set_keymap
  keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  keymap(bufnr, "n", "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<cr>", opts)
  keymap(bufnr, "n", "<leader>li", "<cmd>LspInfo<cr>", opts)
  keymap(bufnr, "n", "<leader>lI", "<cmd>LspInstallInfo<cr>", opts)
  keymap(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
  keymap(bufnr, "n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts)
  keymap(bufnr, "n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts)
  keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
  keymap(bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  keymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
end

local on_attach = function (client, bufnr)
  local active_clients = vim.lsp.get_active_clients()

  if client.server_capabilities.documentSymbolProvider then
    local navic = require('nvim-navic')
    navic.setup({
      depth_limit = 4
    })
    navic.attach(client, bufnr)
  end

  if client.supports_method('textDocument/formatting') then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = augroup,
      buffer = bufnr,
      callback = function ()
        lsp_formatting(bufnr)
      end
    })
  end

  lsp_keymaps(bufnr)
end

local lspconfig = require('lspconfig')
require('mason-lspconfig').setup_handlers({
  function(server_name)
    -- https://zenn.dev/kawarimidoll/articles/2b57745045b225
    local node_root_dir = lspconfig.util.root_pattern('package.json')
    local is_node_repo = node_root_dir(vim.api.nvim_buf_get_name(0)) ~= nil

    local opts = {}

    if server_name == 'tsserver' then
      if not is_node_repo then
        return
      end
      opts.root_dir = node_root_dir
    elseif server_name == 'denols' then
      if is_node_repo then
        return
      end

      opts.root_dir = lspconfig.util.root_pattern('deno.json', 'deno.jsonc', 'deps.ts', 'import_map.json')
      opts.init_options = {
        lint = true,
        unstable = true,
        suggest = {
          imports = {
            hosts = {
              ["https://deno.land"] = true,
              ["https://cdn.nest.land"] = true,
              ["https://crux.land"] = true
            }
          }
        }
      }
    end

    opts.on_attach = on_attach

    lspconfig[server_name].setup(opts)
    vim.diagnostic.config(config)
  end,
})
