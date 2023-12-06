return {
  { "vim-denops/denops.vim", lazy = false },
  {
    "yuki-yano/denops-lazy.nvim",
  },
  { "tani/vim-artemis" },
  { "nvim-lua/plenary.nvim", lazy = false },
  {
    "oflisback/obsidian-bridge.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    event = { "BufReadPre *.md", "BufNewFile *.md" },
    opts = {
      obsidian_server_address = "http://172.25.192.1:27123"
    }
  }
}
