return {
  "isovector/cornelis",
  name = "cornelis",
  ft = "agda",
  build = "nix build .",
  dependencies = { "neovimhaskell/nvim-hs.vim", "kana/vim-textobj-user" },
  version = "*",
}
