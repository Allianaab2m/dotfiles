return {
	{ "https://github.com/vim-denops/denops.vim", lazy = false },
	{
		"https://github.com/yuki-yano/denops-lazy.nvim",
	},
	{ "https://github.com/tani/vim-artemis" },
	{ "https://github.com/nvim-lua/plenary.nvim", lazy = false },
  {
    "https://github.com/oflisback/obsidian-bridge.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    event = { "BufReadPre *.md", "BufNewFile *.md" },
    opts = {
      obsidian_server_address = "http://172.25.192.1:27123"
    }
  }
}
