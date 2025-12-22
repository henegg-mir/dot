{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs = {
    alacritty = {
      enable = true;
      settings = {
        window = {
          opacity = 0.8;
          padding.x = 3;
          padding.y = 1;
          dynamic_padding = true;
        };
        font = {
          size = 11.1;
        };
        keyboard.bindings = [
          {
            key = "T";
            mods = "Control | Shift";
            command = {
              program = "tmux";
              args = [ "new-window" ];
            };
          }
          {
            key = "Tab";
            mods = "Control";
            command = {
              program = "tmux";
              args = [ "next" ];
            };
          }
          {
            key = "Tab";
            mods = "Control | Shift";
            command = {
              program = "tmux";
              args = [ "prev" ];
            };
          }
          {
            key = "W";
            mods = "Control | Shift";
            command = {
              program = "tmux";
              args = [ "killw" ];
            };
          }
          {
            key = "Q";
            mods = "Super";
            command = {
              program = "tmux";
              args = [ "kill-session" ];
            };
          }
        ];
        colors = {
          selection = {
            text = "#1c1621";
            background = "#c8a3bc";
          };
          primary = {
            foreground = "#eed8e5";
            background = "#0c0611";
          };
          normal = {
            black = "#0c0611";
            red = "#b292ac";
            green = "#c8a3bc";
            yellow = "#dab2cc";
            blue = "#a697a0";
            magenta = "#b292ac";
            cyan = "#c8a3bc";
            white = "#dab2cc";
          };
          dim = {
            black = "#90758d";
            red = "#c29eb6";
            green = "#bb9fc2";
            yellow = "#eed8e5";
            blue = "#90758d";
            magenta = "#c29eb6";
            cyan = "#bb9fc2";
            white = "#eed8e5";
          };

        };
      };
    };
  };
}
