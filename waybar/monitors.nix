{
  "sway/workspaces" = {
    "format" = "{icon}";
    "on-click" = "activate";
    "format-icons" = {
      "urgent" = "!";
      "focused" = "[ ]";
      "default" = "+";
    };
  };
  "sway/window" = {
    "format" = "{}";
  };
  "tray" = {
    "spacing" = 10;
  };
  "clock" = {
    "format-alt" = "{:%a %b %d}";
    "format" = "{:%R}";
    "tooltip" = false;
  };

  "idle_inhibitor" = {
    "format" = "{icon}";
    "format-icons" = {
      "activated" = "";
      "deactivated" = "";
    };
    "tooltip" = false;
  };
  "pulseaudio" = {
    "format" = "{icon}  {volume}%";
    "format-bluetooth" = "  {volume}%";
    "format-bluetooth-muted" = " ";
    "format-muted" = "婢";
    "format-icons" = {
      "headphone" = "";
      "hands-free" = "";
      "headset" = "";
      "phone" = "";
      "portable" = "";
      "car" = "";
      "default" = [
        ""
        ""
        ""
      ];
    };
    "on-click" = "pavucontrol";
  };
  "custom/wl-gammarelay-temperature" = {
    "format" = "{} ";
    "exec" = "wl-gammarelay-rs watch {t}";
    "on-scroll-up" =
      "busctl --user -- call rs.wl-gammarelay / rs.wl.gammarelay UpdateTemperature n +100";
    "on-scroll-down" =
      "busctl --user -- call rs.wl-gammarelay / rs.wl.gammarelay UpdateTemperature n -100";
    "tooltip" = false;
  };

  "custom/power-menu" = {
    "format" = " <span color='#bf6188'>⏻ </span>";
    "on-click" = "${../rofi/power.bash} ${../rofi/powermenu.bash} ${../rofi/powermenu.rasi}";
    "tooltip" = false;
  };
}
