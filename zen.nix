{
    
    home = {
        packages = with pkgs [
            passff-host
        ];
    };

    file.passff-host-workaround = {
      target = "${config.home.homeDirectory}/.mozilla/native-messaging-hosts/passff.json";
      source = "${pkgs.passff-host}/share/passff-host/passff.json";
    };

    programs.zen-browser = {
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


}