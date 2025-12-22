{
  config,
  lib,
  pkgs,
  inputs,
  server,
  ...
}:
let
  username = "egg";
  homeDir = "/home/${username}";
  scripts = scripts/.;

in
{

  imports = [
    ./nixvim/default.nix
    inputs.nixvim.homeModules.nixvim
  ]
  ++ (lib.optionals (!server) [
    ./zen.nix
    ./nixcord.nix
    ./kitty.nix
    ./sway.nix
    ./waybar.nix
    ./spicetify.nix
    ./wofi.nix
    ./alacritty.nix
    inputs.nixcord.homeModules.nixcord
    inputs.zen.homeModules.beta
  ]);

  home = {
    username = username;
    homeDirectory = homeDir;
    stateVersion = "25.05";

    packages =
      with pkgs;
      [
        cbonsai
        unzip
        jq
        nerd-fonts.jetbrains-mono
        font-awesome
        powertop
        playerctl
        ghc
        cmake
        gnumake
        nss
        ydotool
        jp2a
        python314
        alsa-utils
        blesh
        any-nix-shell
        rsync
        rar
        wine
        lazygit
        tree-sitter
        ripgrep
        tree
        steamcmd
        pandoc
        texliveTeTeX
      ]
      ++ (lib.optionals (!server) [
        calibre
        obsidian
        zoom-us
        ffmpeg
        nicotine-plus
        gphoto2
        mpv
        quark-goldleaf
        godot
        qbittorrent
        vlc
        autotiling-rs
        swaybg
        icomoon-feather
        wl-gammarelay-rs
        dmenu
        kde-rounded-corners
        blueberry
        polonium
        pavucontrol
        unofficial-homestuck-collection
        blender
        grim
        slurp
        imagemagick
        wl-clipboard
        pulsemeeter
        zoxide
      ]);
    shell = {
      enableFishIntegration = true;
      enableBashIntegration = true;
      enableZshIntegration = true;

    };
    shellAliases = {
      gst = "git status";
    };

    sessionPath = [
      "${scripts}"
    ];

  };

  programs = {
    zathura = {
      enable = true;
      options = {
        exec-command = "-invert-colors";
      };
    };
    git = {
      enable = true;
      settings = {
        user.name = "egg";
        user.email = "egil@guting.se";
        extraConfig = {
          pull.rebase = true;
          init.defaultBranch = "main";
        };
      };
    };
    difftastic = {
      enable = true;
      git.enable = true;
      options.background = "dark";
    };
    eza = {
      enable = true;
      enableFishIntegration = true;
      colors = "auto";
      icons = "auto";
    };
    swappy = {
      enable = true;
      settings = {
        Default = {
          save_dir = "$HOME/Pictures";
        };
      };
    };
    tmux = {
      enable = true;
      extraConfig = ''
        set -g allow-passthrough on
        set -g mouse on
      '';
      plugins = with pkgs; [
        {
          plugin = tmuxPlugins.rose-pine;
          extraConfig = ''
            set -g @rose_pine_variant 'main'
            set -g @rose_pine_disable_active_window_menu 'on'
            set -g @rose_pine_bar_bg_disable 'on'
            set -g @rose_pine_window_separator ':'
          '';
        }
      ];
    };
    fish = {
      enable = true;
      shellAliases = {
        cl = "fish_greeting";
        cd = "z";
        homestuck = "${pkgs.unofficial-homestuck-collection}/bin/unofficial-homestuck-collection";
        ls = "eza -a";
      };
      generateCompletions = true;
      functions = {
        fish_greeting = {
          body = "${./greeting_script/centered_text} ~/images";
        };
      };
      interactiveShellInit = ''
        set -g fish_user_paths ${scripts} $fish_user_paths
         ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
         zoxide init fish | source
      '';
      shellInitLast = ''
        tmux attach || tmux
        direnv hook fish | source
      '';
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        cl = "clear & ${./greeting_script/centered_text} ~/images";
        cd = "z";
        homestuck = "${pkgs.unofficial-homestuck-collection}/bin/unofficial-homestuck-collection";
        ls = "eza -a";
        ll = "eza -l";
      };
      history.size = 10000;
      initContent = lib.mkMerge [
        (lib.mkOrder 1000 ''
          tmux attach || tmux
          any-nix-shell zsh --info-right | source /dev/stdin
          ${./greeting_script/centered_text} ~/images
        '')
        (lib.mkOrder 1500 ''
          eval "$(direnv hook zsh)"
          eval "$(zoxide init zsh)"
        '')
      ];
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
        '')
      ];
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
      thunderbird = {
        enable = true;
        profiles = [ "egg" ];
        settings = id: {
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
        profiles = [ "egg" ];
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
    pinentry.package = pkgs.pinentry-gnome3;
  };
  services.mako.settings = {
    enable = true;
    defaultTimeout = 3000;
  };
}
