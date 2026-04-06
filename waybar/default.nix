{ pkgs, ... }:
let
  config = pkgs.writeText "config.json" (builtins.toJSON (import ./monitors.nix));
in
{
  programs.waybar = {
    enable = true;
    style = ''
      * {
      /* `otf-font-awesome` is required to be installed for icons */
      font-family: "JetBrainsMono Nerd Font";
      font-size: 17px;
      }
      window.DP-4 * { font-size: 18px; }
      window.DP-6 * { font-size: 22px; }
      window#waybar {
      background-color: rgba(83, 83, 90, 0.0);
      color: #ffffff;
      transition-property: background-color;
      transition-duration: 0.5s;
      border-top: 8px transparent;
      border-radius: 8px;
      transition-duration: 0.5s;
      margin: 16px 16px;
      }

      window#waybar.hidden {
      opacity: 0.2;
      }

      #workspaces button {
      padding: 0 5px;
      color:#ff99cc;
      background-color: transparent;
      /* Use box-shadow instead of border so the text isn't offset */
      box-shadow: inset 0 -3px transparent;
      /* Avoid rounded borders under each workspace name */
      border: none;
      border-radius: 8px;
      }

      #workspaces button.focused {
      color:#d147a3;
      }

      #workspaces button.active {
      color: #6a92d7;
      }

      #window {
      /* border-radius: 20px; */
      /* padding-left: 10px; */
      /* padding-right: 10px; */
      color: #64727d;
      }

      #clock,
      #battery,
      #cpu,
      #memory,
      #disk,
      #temperature,
      #backlight,
      #network,
      #pulseaudio,
      #custom-media,
      #tray,
      #mode,
      #mpd,
      #bluetooth,
      #custom-power-menu,
      #custom-spotify,
      #custom-weather,
      #custom-weather.severe,
      #custom-weather.sunnyDay,
      #custom-weather.clearNight,
      #custom-weather.cloudyFoggyDay,
      #custom-weather.cloudyFoggyNight,
      #custom-weather.rainyDay,
      #custom-weather.rainyNight,
      #custom-weather.showyIcyDay,
      #custom-weather.snowyIcyNight,
      #custom-weather.default {
      padding: 0 10px;
      color: #e5e5e5;
      /* color: #bf616a; */
      border-radius: 9.5px;
      background-color:rgba(32, 32, 32, 0.66);
      }

      #battery {
      background-color:rgb(28, 31, 34);
      }

      #window,
      #workspaces {
      margin: 0 4px;
      padding: 0 7 0 3px;
      border-radius: 7.8px;
      background-color:rgba(32, 32, 32, 0.75);
      }

      #cpu {
      color: #fb958b;
      background-color: #1f2530;
      }

      #memory {
      color: #ebcb8b;
      background-color: #1f2530;
      }

      #custom-wl-gammarelay-temperature,
      #custom-power-menu {
      border-radius: 9.5px;
      background-color:rgba(35, 30, 49, 0.73);
      border-radius: 7.5px;
      padding: 0 5px;
      }

      #custom-power-menu{
          padding: 0 7 0 3px;
      }

      #custom-launcher {
      background-color: #1b242b;
      color: #6a92d7;
      border-radius: 7.5px;
      padding: 0 3px;
      }

      #custom-weather.severe {
      color: #eb937d;
      }

      #custom-weather.sunnyDay {
      color: #c2ca76;
      }

      #custom-weather.clearNight {
      color: #cad3f5;
      }

      #custom-weather.cloudyFoggyDay,
      #custom-weather.cloudyFoggyNight {
      color: #c2ddda;
      }

      #custom-weather.rainyDay,
      #custom-weather.rainyNight {
      color: #5aaca5;
      }

      #custom-weather.showyIcyDay,
      #custom-weather.snowyIcyNight {
      color: #d6e7e5;
      }

      #custom-weather.default {
      color: #dbd9d8;
      }

      /* If workspaces is the leftmost module, omit left margin */
      .modules-left > widget:first-child > #workspaces {
      margin-left: 0;
      }

      /* If workspaces is the rightmost module, omit right margin */
      .modules-right > widget:last-child > #workspaces {
      margin-right: 0;
      }

      #pulseaudio {
      color: #7d9bba;
      }

      #backlight {
      /* color: #EBCB8B; */
      color: #8fbcbb;
      }

      #clock {
      color: #c8d2e0;
      background-color: rgba(0,0,0,0);
      }

      #battery {
      color: #c0caf5;
      /* background-color: #90b1b1; */
      }

      #battery.charging,
      #battery.full,
      #battery.plugged {
      color: #26a65b;
      /* background-color: #26a65b; */
      }

      @keyframes blink {
      to {
          background-color: rgba(30, 34, 42, 0.5);
          color: #abb2bf;
      }
      }

      #battery.critical:not(.charging) {
      color: #f53c3c;
      animation-name: blink;
      animation-duration: 0.5s;
      animation-timing-function: linear;
      animation-iteration-count: infinite;
      animation-direction: alternate;
      }

      label:focus {
      background-color: #000000;
      }

      #disk {
      background-color: #964b00;
      }

      #bluetooth {
      color: #707d9d;
      }

      #bluetooth.disconnected {
      color: #f53c3c;
      }

      #network {
      color: #b48ead;
      }

      #network.disconnected {
      color: #f53c3c;
      }

      #custom-media {
      background-color: #66cc99;
      color: #2a5c45;
      min-width: 100px;
      }

      #custom-media.custom-spotify {
      background-color: #66cc99;
      }

      #custom-media.custom-vlc {
      background-color: #ffa000;
      }

      #temperature {
      background-color: #f0932b;
      }

      #temperature.critical {
      background-color: #eb4d4b;
      }

      #tray > .passive {
      -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
      -gtk-icon-effect: highlight;
      background-color: #eb4d4b;
      }

      #idle_inhibitor {
      padding: 0 15 0 7px;
      color: rgb(161, 139, 172);
      border-radius: 9.5px;
      background-color:rgb(30, 34, 37);
      }

      #idle_inhibitor.activated {
      background-color:rgb(161, 139, 172);
      color: rgb(30, 34, 37);
      }

      #custom-monitor-1,
      #custom-monitor-2,
      #custom-monitor-3 {
      padding: 0 7 0 7px;
      color: rgb(124, 153, 48);
      border-radius: 9.5px;
      background-color:rgb(30, 34, 37);
      }

      #custom-monitor-1.active,
      #custom-monitor-2.active,
      #custom-monitor-3.active {
      background-color:rgb(124, 153, 48);
      color: rgb(30, 34, 37);
      }
      #custom-monitor-2 {
      color: rgb(111, 62, 224);
      }
      #custom-monitor-2.active{
      background-color: rgb(111, 62, 224);
      }
      #custom-monitor-3 {
      color: rgb(237, 109, 156);
      margin: 0 10 0 0px
      }
      #custom-monitor-3.active{
      background-color: rgb(237, 109, 156);
      }

      #custom-left-sep,
      #custom-right-sep {
      background-color: rgba(0,0,0,0);
      }
      #custom-right-sep:hover {
      animation-name: slide-right;
      animation-duration: 2s;
      }
      @keyframes slide-right {

        from {
          margin-left: 0px;
        }

        50% {
          margin-left: 110px;
          opacity: 1;
        }

        50% {
          opacity: 0.9;
        }

        to {
          margin-left: 200px;
        }

      }
      #mpd {
      color: #2a5c45;
      }

      #mpd.disconnected {
      color: #f53c3c;
      }

      #mpd.stopped {
      color: #90b1b1;
      }

      #mpd.paused {
      color: #51a37a;
      }

      #language {
      background: #00b093;
      color: #740864;
      padding: 0 5px;
      margin: 0 5px;
      min-width: 16px;
      }

      #keyboard-state {
      background: #97e1ad;
      color: #000000;
      padding: 0 0px;
      margin: 0 5px;
      min-width: 16px;
      }

      #keyboard-state > label {
      padding: 0 5px;
      }

      #custom-spotify {
      padding: 0 10px;
      margin: 0 4px;
      /* background-color: #1db954; */
      color: #abb2bf;
      }

      #keyboard-state > label.locked {
      background: rgba(0, 0, 0, 0.2);
      }
    '';
    settings = [
      {
        height = 30;
        "layer" = "top";
        "margin-top" = 6;
        "margin-left" = 10;
        "margin-bottom" = 0;
        "margin-right" = 10;
        "spacing" = 5;
        output = [
          "DP-4"
          "DP-6"
        ];
        "include" = [
          config
        ];
        modules-left = [
          "sway/workspaces"
        ];
        modules-center = [
          "custom/left-sep"
          "clock"
          "custom/right-sep"
        ];
        modules-right = [
          "custom/monitor-1"
          "custom/monitor-2"
          "custom/monitor-3"
          "idle_inhibitor"
          "custom/wl-gammarelay-temperature"
          "pulseaudio"
          "custom/power-menu"
        ];
      }
      {
        height = 30;
        "layer" = "top";
        "margin-top" = 6;
        "margin-left" = 10;
        "margin-bottom" = 0;
        "margin-right" = 10;
        "spacing" = 5;
        output = [
          "DP-5"
        ];
        "include" = [
          config
        ];
        modules-left = [
          "sway/workspaces"
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [
          "custom/monitor-1"
          "custom/monitor-2"
          "custom/monitor-3"
          "idle_inhibitor"
          "custom/wl-gammarelay-temperature"
          "pulseaudio"
          "custom/power-menu"
        ];
      }
      {
        height = 30;
        "layer" = "top";
        "margin-top" = 6;
        "margin-left" = 10;
        "margin-bottom" = 0;
        "margin-right" = 10;
        "spacing" = 5;
        output = [
          "eDP-1"
        ];
        "include" = [
          config
        ];
        modules-left = [
          "sway/workspaces"
        ];
        modules-center = [
          "custom/left-sep"
          "clock"
          "custom/right-sep"
        ];
        modules-right = [
          "idle_inhibitor"
          "backlight"
          "custom/wl-gammarelay-temperature"
          "pulseaudio"
          "battery"
          "custom/power-menu"
        ];
        "backlight" = {
          "device" = "DP-1";
          "format" = "{icon} {percent}%";
          "format-icons" = [
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
          ];
          "on-click" = "";
          "tooltip" = false;
        };
        "battery" = {
          "bat" = "BAT1";
          "adapter" = "ADP0";
          "interval" = 60;
          "states" = {
            "warning" = 30;
            "critical" = 15;
          };
          "max-length" = 20;
          "format" = "{icon} {capacity}%";
          "format-warning" = "{icon} {capacity}%";
          "format-critical" = "{icon} {capacity}%";
          "format-charging" = " {capacity}%";
          "format-plugged" = "  {capacity}%";
          "format-alt" = "{icon} {time}";
          "format-full" = "  {capacity}%";
          "format-icons" = [
            " "
            " "
            " "
            " "
            " "
          ];
          "tooltip" = false;
        };
      }
    ];
  };
}
