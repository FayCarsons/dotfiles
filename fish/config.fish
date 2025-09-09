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
fish_add_path -a ~/.cabal/bin
fish_add_path -a ~/.config/doom/bin
fish_add_path -a ~/.config/emacs/bin
fish_add_path /nix/var/nix/profiles/default/bin
fish_add_path ~/.nix-profile/bin
fish_add_path /run/current-system/sw/bin

set -x SOPS_AGE_KEY_FILE ~/.config/sops/age/keys.txt
set -x CACHIX_KEY eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiI2ZDdjMzk2Ni0wY2FlLTRmNDMtOTQyMS01NzZiMzAzNzE2MDciLCJzY29wZXMiOiJjYWNoZSJ9.ikE4t9-OnBGHin4b60qhz1eCK56dk6YVHw0MuUsuYQc

eval (/opt/homebrew/bin/brew shellenv)
