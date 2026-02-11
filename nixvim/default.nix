{ pkgs, ... }:
{
  imports = [
    ./treesitter.nix
    ./lsp.nix
    ./colorscheme.nix
    ./lazygit.nix
    ./keybindings.nix
    ./which-key.nix
    ./barbar.nix
    ./telescope.nix
    ./indent-o-matic.nix
    ./image.nix
    ./oil.nix
    ./lualine.nix
    ./markdown-preview.nix
    ./cmp.nix
    ./instant.nix
  ];

  programs.nixvim.enable = true;
  programs.nixvim.clipboard.register = "unnamedplus";

  programs.nixvim.extraPlugins = [ pkgs.vimPlugins.live-share-nvim ];
}
