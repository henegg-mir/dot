{
  programs.nixvim.plugins = {
    blink-cmp.enable = true;
    cmp = {
      autoEnableSources = false;
      enable = false;
      settings = {
        sources = [
          { name = "nvim_lsp"; }
          { name = "path"; }
          { name = "buffer"; }
        ];
        preselect = # Lua
          "cmp.PreselectMode.None";
      };
    };
    cmp-nvim-lsp.enable = false;
    cmp-buffer.enable = false;
    cmp-path.enable = false;
  };

}
