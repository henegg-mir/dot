{ config, lib, pkgs, ... }:
let 
    modifier = config.wayland.windowManager.sway.config.modifier;
in
{
    wayland.windowManager.sway = {
        checkConfig = false;
        enable = true;
        package = pkgs.swayfx;
        config = {
            colors = {
                focused = {
                    background = "#222222";
                    border = "#333333";
                    childBorder = "#5f676a";
                    indicator = "#830857";
                    text = "#888888";
                };
                focusedInactive = {
                    background = "#5f676a";
                    border = "#333333";
                    childBorder = "#222222";
                    indicator = "#222222";
                    text = "#ffffff";
                };
            };
            bars = [];
            terminal = "kitty";
            modifier = "Mod4";
            startup = [
            {command = "wl-gammarelay-rs";}
            {command = "waybar";}
            {command = "swayidle -w timeout 300 '${./swaylock.bash} --grace 2 --fade-in 0.2' timeout 900 'systemctl suspend' before-sleep '${./swaylock.bash}'";}
            {command = "autotiling-rs";}
            ];
            gaps = {
                outer = 5;
                inner = 10;
            };
            keybindings = {
            "${modifier}+l" = "exec ${./swaylock.bash}";
            "${modifier}+Return" = "exec ${pkgs.kitty}/bin/kitty";
            "${modifier}+p" = "exec ${rofi/passmenu.bash} --type";
            "${modifier}+p+Shift" = "exec ${rofi/passmenu.bash}";
            "${modifier}+q" = "kill";
            "${modifier}+m" = "exec ${pkgs.wofi}/bin/wofi --show run";
            "${modifier}+d" = "exec ${pkgs.wofi}/bin/wofi --show drun";
            "${modifier}+1" = "workspace number 1";
            "${modifier}+3" = "workspace number 3";
            "${modifier}+4" = "workspace number 4";
            "${modifier}+5" = "workspace number 5";
            "${modifier}+2" = "workspace number 2";
            "${modifier}+6" = "workspace number 6";
            "${modifier}+7" = "workspace number 7";
            "${modifier}+8" = "workspace number 8";
            "${modifier}+9" = "workspace number 9";
            "${modifier}+0" = "workspace number 10";
            "${modifier}+Shift+1" = "move container to workspace number 1";
            "${modifier}+Shift+2" = "move container to workspace number 2";
            "${modifier}+Shift+3" = "move container to workspace number 3";
            "${modifier}+Shift+4" = "move container to workspace number 4";
            "${modifier}+Shift+5" = "move container to workspace number 5";
            "${modifier}+Shift+6" = "move container to workspace number 6";
            "${modifier}+Shift+7" = "move container to workspace number 7";
            "${modifier}+Shift+8" = "move container to workspace number 8";
            "${modifier}+Shift+9" = "move container to workspace number 9";
            "${modifier}+Shift+0" = "move container to workspace number 10";
            "${modifier}+i" = "exec busctl --user -- call rs.wl-gammarelay / rs.wl.gammarelay UpdateTemperature n -100";
            "${modifier}+o" = "exec busctl --user call rs.wl-gammarelay / rs.wl.gammarelay UpdateTemperature n 100";
            "${modifier}+f" = "fullscreen";
            "${modifier}+Shift+space" = "floating toggle";
            "${modifier}+Shift+left" = "move left";
            "${modifier}+Shift+right" = "move right";
            "${modifier}+Shift+up" = "move up";
            "${modifier}+Shift+down" = "move down";
            "${modifier}+left" = "workspace prev";
            "${modifier}+right" = "workspace next";

            "XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
            "XF86MonBrightnessUp" = "exec brightnessctl set 5%+";
            "XF86AudioRaiseVolume" = "exec pactl set-sink-volume 0 +5%";
            "XF86AudioLowerVolume" = "exec pactl set-sink-volume 0 -5%";
            "XF86AudioMute" = "exec pactl set-sink-mute 0 toggle";
            "XF86AudioPlay" = "exec playerctl play-pause";
            "XF86AudioNext" = "exec playerctl next";
            "XF86AudioPrev" = "exec playerctl previous";
            #"XF86AudioMicMute" = exec pamixer --default-source -t
            };
	    input."*".xkb_layout = "se";
        input."5426:110:Razer_Razer_DeathAdder_Essential".natural_scroll = "disabled";
	    input."*".natural_scroll = "enabled";
	    input."*".scroll_factor = "2.5";
        input."*" = {
            tap = "enabled";
            dwt = "enabled";
            middle_emulation = "enabled";
        };
            window.titlebar = false;
        };
        extraConfig = ''
            bindgesture swipe:right workspace prev
            bindgesture swipe:left workspace next
	        corner_radius 10
            for_window [class="Code"] opacity 0.78
            for_window [class="Spotify"] opacity 0.90
            for_window [app_id="kitty"] opacity 1
            for_window [class="vesktop"] opacity 0.90
            for_window [title="Picture-in-Picture"] floating enable, sticky enable
            for_window [app_id ="org.pulseaudio.pavucontrol"] floating enable
            for_window [app_id ="org.pulseaudio.pavucontrol"] opacity 0.90
            for_window [app_id ="blueberry.py"] opacity 0.90
            for_window [app_id ="grc-prompter"] opacity 0.90
            bindsym Shift+Ctrl+h             resize shrink width  5 px or 5 ppt
            bindsym Shift+Ctrl+k             resize grow   height 5 px or 5 ppt
            bindsym Shift+Ctrl+j             resize shrink height 5 px or 5 ppt
            bindsym Shift+Ctrl+l             resize grow   width  5 px or 5 ppt

            layer_effects "kitty" {
                blur enable
            }
            
            layer_effects "waybar" {
                blur enable
                blur_ignore_transparent enable
            }

            layer_effects "wofi" {
                blur enable
                corner_radius 15
            }
            set $laptop eDP-1
            set $monitor_1 "AOC 24P1W1 HEBM4HA026735"
            set $monitor_2 "Huawei Technologies Co., Inc. XWU-CBA 0x00000001"
            bindswitch --reload --locked lid:on output $laptop disable
            bindswitch --reload --locked lid:off output $laptop enable
            exec_always ${./clamshell.sh}

            workspace 1 output $monitor_1
            workspace 2 output $monitor_1
            workspace 3 output $monitor_1
            workspace 4 output $monitor_1
            workspace 5 output $monitor_1 HDMI-A-1
            workspace 6 output $monitor_2
            workspace 7 output $monitor_2
            workspace 8 output $monitor_2
            workspace 9 output $monitor_2
            workspace 10 output $monitor_2

            output $monitor_1 pos 0 0 res 1920x1080@59.940Hz power on bg ${./dream.jpg} fill scale_filter nearest
            output $monitor_2 pos 1920 0 res 2560x1440@59.940Hz power on bg ${./dream.jpg} fill scale_filter nearest
            output eDP-1 res 1920x1080@59.997Hz bg ${./dream.jpg} fill scale_filter nearest

        '';

    };

}
