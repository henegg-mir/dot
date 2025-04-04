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
      nss
      passff-host
    ];
  };

  home.file.passff-host-workaround = {
    target =
      "${config.home.homeDirectory}/.mozilla/native-messaging-hosts/passff.json";
    source = "${pkgs.passff-host}/share/passff-host/passff.json";
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
      defaultTimeout = 3000;
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      
    };
    vscode = {
      enable = true;
    };
    thunderbird = {
      enable = true;
      profiles = {
        egg = {
          isDefault = true;
        };
      };
    };
    password-store = {
        enable = true;
        package = pkgs.pass-wayland;
    };
    
  };
  accounts.email.accounts = {
    chalmers = {
      address = "guting@chalmers.se";
      flavor = "outlook.office365.com";
      thunderbird= {
        enable = true;
        profiles = ["egg"];
        settings =
        id: {
          "mail.server.server_${id}.authMethod" = 10;
          "mail.smtpserver.smtp_${id}.authMethod" = 10;
        };
      };
      primary = false;
      imap = {
        host = "outlook.office365.com";
        port = 993;
        tls.enable = true;
      };
      realName = "Egil Guting";
    };
    guting = {
      address = "egil@guting.se";
      thunderbird = {
        enable = true;
        profiles = ["egg"];
      };
      primary = true;
      imap = {
        host = "imap.one.com";
        port = 993;
        tls.enable = true;
      };
      smtp = {
        host = "send.one.com";
        port = 587;
        tls = {
          enable = true;
          useStartTls = true;
        };
      };
      realName = "Egil Guting";
      userName = "egil@guting.se";
    };
  };
  news.display = "silent";
  programs.home-manager.enable = true;
  fonts.fontconfig.enable = true;
  services.kdeconnect.enable = true;

}
