return {
  "Julian/lean.nvim",
  event = { "BufReadPre *.lean", "BufNewFile *.lean" },
  dependencies = {
    "neovim/nvim-lspconfig",
    "nvim-lua/plenary.nvim",
    "saghen/blink.cmp",
    "tomtom/tcomment_vim",
  },
  opts = { mappings = true },
}
