{
    programs.nixvim = {
        colorschemes.catppuccin = {
            enable = true;
            settings = {
                flavour = "macchiato";
                integrations = {
                    cmp = true;
                    gitsigns = true;
                    treesitter = true;
                    notify = true;
                    mini = {
                        enabled = true;
                    };
                };
            };
        };
        plugins = {
            transparent.enable = true;
            web-devicons.enable = true;
        };
    };
}