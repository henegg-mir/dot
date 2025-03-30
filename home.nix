{ config, lib, pkgs, inputs, ... }:
let
  username = "egg";
  homeDir = "/home/${username}";

in
{

  imports = [
    ./kitty.nix
    ./sway.nix
    ./waybar.nix
    ./spicetify.nix
    inputs.nixcord.homeManagerModules.nixcord
  ];

  home = {
    username = username;
    homeDirectory = homeDir;
    stateVersion = "24.11";

    packages = with pkgs; [
      blueberry
    	neovim
      inputs.zen.packages."x86_64-linux".beta
      polonium
      cbonsai
      pavucontrol
      kde-rounded-corners
      unzip
      dmenu
      jq
      wl-gammarelay-rs
      nerd-fonts.jetbrains-mono
      font-awesome
      swaybg
      icomoon-feather
      powertop
      playerctl
      autotiling-rs
      ghc
      SDL2
      mesa
      glm
      imgui
      cmake
      gnumake
      qbittorrent
      vlc
    ];
  };

  

  programs = {
    git = {
      enable = true;
      userName = "egg";
      userEmail = "egil@guting.se";
      difftastic = {
        enable = true;
        background = "dark";
      };
      extraConfig = {
        pull.rebase = true;
        init.defaultBranch = "main";
      };
    };
    fish = {
      enable = true;
      shellAliases = {
        cl = "fish_greeting";
      };
      generateCompletions = true;
      functions = {
        fish_greeting = {
          body = "cbonsai -p";
        };
      };
      shellInitLast = "direnv hook fish | source";
    };
    rofi = {
      enable = true;
      theme = "${./rofi/rounded_muted.rasi}";
    };
    nixcord = {
      enable = true;
      discord.enable = false;
      vesktop.enable = true;
      config.themeLinks = ["https://catppuccin.github.io/discord/dist/catppuccin-mocha.theme.css"
      ];
    };
    swaylock = {
      enable = true;
      package = pkgs.swaylock-effects;
    };
    mako = {
      enable = true;
      defaultTimeout = 1000;
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    vscode = {
      enable = true;
    };

    
  };

  news.display = "silent";
  programs.home-manager.enable = true;
  fonts.fontconfig.enable = true;
}
