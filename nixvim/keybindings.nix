{
    programs.nixvim = {
        globals = {
            mapleader = " ";
            maplocalleader = " ";
        };
        keymaps = [
            {
                mode = "n";
                key = "<leader>lg";
                action = "<cmd>LazyGit<CR>";
                options = {
                    desc = "LazyGit";
                };
            }
        ];
    };
}