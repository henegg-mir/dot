{ pkgs, ... }:
{
  imports = [
    ./neo-tree.nix
    ./dashboard.nix
    ./treesitter.nix
    ./dap.nix
    ./lsp.nix
    ./direnv.nix
    ./colorscheme.nix
    ./lazygit.nix
    ./keybindings.nix
    ./which-key.nix
    ./barbar.nix
    ./telescope.nix
    ./sleuth.nix
    ./image.nix
    ./oil.nix
    ./lualine.nix
    ./markdown-preview.nix
    ./cmp.nix
    ./instant.nix
    ./noice.nix
  ];

  programs.nixvim = {
    enable = true;
    clipboard.register = "unnamedplus";
    diagnostic.settings = {
      virtual_lines = {
        current_line = true;
      };
      virtual_text = true;
    };
    extraPlugins = [ pkgs.vimPlugins.live-share-nvim ];
  };
}
