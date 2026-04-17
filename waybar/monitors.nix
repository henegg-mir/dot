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
  "custom/monitor-1" = {
    "exec" = "python ${../scripts/monitor-watch.py} 0x000A4E82";
    "on-click" = "sleep 0.1 && python ${../scripts/monitor-toggle.py} 0x000A4E82";
    "interval" = 1;
    "return-type" = "json";
    "format" = "{icon}";
    "format-icons" = {
      "active" = "☘";
      "deactive" = "☘";
    };
    "tooltip" = false;
  };
  "custom/monitor-2" = {
    "exec" = "python ${../scripts/monitor-watch.py} 0x00000001";
    "on-click" = "sleep 0.1 && python ${../scripts/monitor-toggle.py} 0x00000001";
    "interval" = 1;
    "return-type" = "json";
    "format" = "{icon}";
    "format-icons" = {
      "active" = "✽";
      "deactive" = "✽";
    };
    "tooltip" = false;
  };
  "custom/monitor-3" = {
    "exec" = "python ${../scripts/monitor-watch.py} HEBM4HA026735";
    "on-click" = "sleep 0.1 && python ${../scripts/monitor-toggle.py} HEBM4HA026735";
    "interval" = 1;
    "return-type" = "json";
    "format" = "{icon}";
    "format-icons" = {
      "active" = "✿";
      "deactive" = "✿";
    };
    "tooltip" = false;
  };
  "custom/left-sep" = {
    "exec" = "${../scripts/rainbow.sh} -r";
    "tooltip" = false;
  };
  "custom/right-sep" = {
    "exec" = "${../scripts/rainbow.sh}";
    "tooltip" = false;
  };
}
