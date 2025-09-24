{ config, lib, pkgs, inputs, ... }:

{
  imports = [ inputs.nixvim.homeModules.nixvim ];

  programs.nixvim = {
    enable = true;
    colorschemes = {
      catppuccin = {
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
      };
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };
    plugins = {
        lazygit.enable = true;
	transparent.enable = true;
	nix.enable = true;
	treesitter = {
	enable = true;
	
	    nixvimInjections = true;
	    folding = true;
	    settings = {
	    indent.enable = true;
	    highlight.enable = true;
	    # ensure_installed = "all";
	    auto_install = true;
	    };
	};

	    treesitter-refactor = {
	        enable = true;
		highlightDefinitions = {
		    enable = true;
		    # Set to false if you have an `updatetime` of ~100.
		    clearOnCursorMove = false;
		    };
		};
	hmts.enable = true;
	telescope = {
	enable = true;

	settings.defaults = {
        file_ignore_patterns = [
          "^.git/"
          "^.mypy_cache/"
          "^__pycache__/"
          "^output/"
          "^data/"
        ];
        set_env.COLORTERM = "truecolor";
      };
      };
    };

    keymaps = [
      {
            action = ":LazyGit<CR>";
            key = "<leader>lg";
            options = {
            silent = true;
            noremap = true;
            desc = "Open lazygit";
            };
	}

      # Telescope search (live grep)
      {
        action = ":Telescope live_grep<CR>";
        key = "<leader>sg";
        options = {
          silent = true;
          noremap = true;
          desc = "Search grep";
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
      # Telescope search commands
      {
        action = ":Telescope commands<CR>";
        key = "<leader>sc";
        options = {
          silent = true;
          noremap = true;
          desc = "Search commands";
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
      # Telescope undo tree
      {
        action = ":Telescope undo<CR>";
        key = "<leader>u";
        options = {
          silent = true;
          noremap = true;
          desc = "Undo tree";
        };
      }
        ];
    };
}
