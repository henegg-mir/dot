{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
    programs.nixvim.plugins.treesitter = {
        enable = true;
        settings = {
            highlight.enable = true;
        };
    };
}
