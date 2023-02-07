local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath
  })
end
vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup(require("plugins"), {
  defaults = { lazy = true },
  dev = {
    path = "~/ghq/github.com/Allianaab2m",
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "netrwPlugin",
        "tutor"
      },
      rtp = {
	reset = false
      }
    },
  },
})

require("core")

vim.g.fuzzy_motion_matchers = { 'fzf', 'kensaku' }
-- vim.opt.ambiwidth = 'double'
vim.api.nvim_create_user_command('Filetree', [[ call ddu#start({ 'name': 'filer', 'uiParams': {'filer': {'search': expand('%:p')}}}) ]], {})
vim.api.nvim_create_user_command('SkipSong', [[ call system('playerctl next') ]], {})

vim.cmd[[nnoremap <expr> <leader>f "<Cmd>FuzzyMotion<CR>"]]
vim.cmd[[nnoremap <C-j> <Cmd>call jumpout#select_jump('j', ['bo term', 'Trouble workspace_diagnostics'])<CR>]]
vim.cmd[[nnoremap <C-h> <Cmd>call jumpout#jump('h', 'Filetree')<CR>]]

