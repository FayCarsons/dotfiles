theme_gruvbox dark medium
fish_vi_key_bindings

abbr -a ls eza
abbr -a grep rg 
abbr -a c clear
abbr -a cat bat
abbr -a yank pbcopy
abbr -a g lazygit
abbr -a esp '. /Users/faycarsons/export-esp.sh'

# Remove the incorrect entry
set PATH (string match -v '/usr/local/neovim/bin' $PATH)

# Add the correct one
fish_add_path -a /usr/local/nvim-macos-arm64/bin
fish_add_path -a ~/.cargo/bin
fish_add_path -a ~/.ghcup/bin
fish_add_path -a ~/.config/doom/bin
fish_add_path -a ~/.config/emacs/bin

eval (/opt/homebrew/bin/brew shellenv)
