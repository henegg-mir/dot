{ config, lib, pkgs, inputs, ... }:
let
  username = "egg";
  homeDir = "/home/${username}";
  scripts = scripts/.;

in
{

  imports = [
    ./kitty.nix
    ./sway.nix
    ./waybar.nix
    ./spicetify.nix
    ./wofi.nix
    ./nixvim.nix
    inputs.nixcord.homeModules.nixcord
    inputs.zen.homeModules.beta
  ];

  home = {
    username = username;
    homeDirectory = homeDir;
    stateVersion = "24.11";

    packages = with pkgs; [
      blueberry
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
      ydotool
      jp2a
      python314
      alsa-utils
      blesh
      any-nix-shell
      rsync
      zoom-us
      ffmpeg
      gphoto2
      mpv
      quark-goldleaf
      rar
      wine
      calibre
      obsidian
      nicotine-plus
      godot
      lazygit
      tree-sitter
      ripgrep
      tree
    ];
    shell = {
      enableFishIntegration = true;
      enableBashIntegration = true;
    };
    shellAliases = {
        gst = "git status";
      };
    
    sessionPath = [
      "${scripts}"
    ];

    file.passff-host-workaround = {
    target =
      "${config.home.homeDirectory}/.mozilla/native-messaging-hosts/passff.json";
    source = "${pkgs.passff-host}/share/passff-host/passff.json";
    };
  };


  

  programs = {
    zen-browser = {
      enable = true;
      profiles.egg = {
        isDefault = true;
        settings = {
          "zen.workspaces.show-workspace-indicator" = false;
          "mousewheel.default.delta_multiplier_y" = 100;
          "apz.gtk.kinetic_scroll.enabled" = false;
          "zen.welcome-screen.seen" = true;
        };
        search.default = "ddg";
        search.force = true;
        search.privateDefault = "ddg";
      };
      policies = {
        DisableAppUpdate = true;
        DisableTelemetry = true;
        # find more options here: https://mozilla.github.io/policy-templates/
      };
    };
    zathura = {
      enable = true;
      options = {
        exec-command = "-invert-colors";
      };
    };
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
        ls = "ls -a";
      };
      generateCompletions = true;
      functions = {
        fish_greeting = {
          body = "${./greeting_script/centered_text} ~/images ${greeting_script/lines.py}";
        };
      };
      interactiveShellInit = ''
        set -g fish_user_paths ${scripts} $fish_user_paths
         ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
      '';
      shellInitLast = "direnv hook fish | source";
    };
    bash = {
      enable = true;
      enableCompletion = true;
      initExtra = lib.mkMerge [
      (lib.mkBefore ''
        [[ $- == *i* ]] && source "$(blesh-share)"/ble.sh --noattach
      '')
      (lib.mkAfter ''
        [[ ! ''\${BLE_VERSION-} ]] || ble-attach
          . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
      '')];
    };
    rofi = {
      enable = true;
      theme = "${./rofi/rounded_muted.rasi}";
      plugins = [pkgs.rofi-games];
    };

    nixcord = {
      enable = true;
      discord.enable = false;
      vesktop.enable = true;
      config.themeLinks = ["https://refact0r.github.io/system24/build/system24.css"
      ];
    };
    swaylock = {
      enable = true;
      package = pkgs.swaylock-effects;
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
        settings = { 
          PASSWORD_STORE_DIR = "${homeDir}/.password-store"; 
          PASSWORD_STORE_KEY = "AFE7F120FFC5258BF3A6762CB78E5600D1573D1D";
        };
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
  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-gnome3;
  };
  services.mako = {
    enable = true;
    defaultTimeout = 3000;
  };
}
