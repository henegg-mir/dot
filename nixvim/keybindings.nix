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
      {
        action = ":BufferNext<CR>";
        key = "<Tab>";
        options = {
          silent = true;
          noremap = true;
          desc = "Next buffer";
        };
      }
      {
        action = ":BufferPrevious<CR>";
        key = "<S-Tab>";
        options = {
          silent = true;
          noremap = true;
          desc = "Prev buffer";
        };
      }
      # Open Ntree
      {
        action = ":Neotree toggle<CR>";
        key = "<leader>nt";
        options = {
          desc = "Neo-tree";
        };
      }
      # oil mapping for file tree
      {
        action = ":Oil<CR>";
        key = "<leader>o";
        options = {
          silent = true;
          noremap = true;
          desc = "Oil";
        };
      }
      # Telescope search buffers
      {
        action = ":Telescope buffers<CR>";
        key = "<leader>sb";
        options = {
          silent = true;
          noremap = true;
          desc = "Search buffers";
        };
      }
      # Telescope search commands
      {
        action = ":Telescope command_history<CR>";
        key = "<leader>sc";
        options = {
          silent = true;
          noremap = true;
          desc = "Search commands";
        };
      }
      # Telescope search files
      {
        action = ":Telescope find_files<CR>";
        key = "<leader>sf";
        options = {
          silent = true;
          noremap = true;
          desc = "Search files";
        };
      }
      # Telescope search references
      {
        action = ":Telescope lsp_references<CR>";
        key = "<leader>sr";
        options = {
          silent = true;
          noremap = true;
          desc = "Search references";
        };
      }
      # Telescope live grep
      {
        action = ":Telescope live_grep<CR>";
        key = "<leader>sg";
        options = {
          silent = true;
          noremap = true;
          desc = "Live grep";
        };
      }
      # Telescope quickfixlist
      {
        action = ":Telescope quickfix<CR>";
        key = "<leader>ql";
        options = {
          silent = true;
          noremap = true;
          desc = "Quickfix list";
        };
      }
      # Dashboard
      {
        action = ":Dashboard<CR>";
        key = "<leader>db";
        options = {
          silent = true;
          noremap = true;
          desc = "Dashboard";
        };
      }
    ];
  };
}
