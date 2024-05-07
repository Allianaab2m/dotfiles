return {
  "https://github.com/lewis6991/gitsigns.nvim",
  event = "VeryLazy",
  config = {
    signcolumn = true,
    attach_to_untracked = true,
    current_line_blame = true,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'eol',
      delay = 250,
    }
  }
}
