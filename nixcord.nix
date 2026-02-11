{
    programs.vesktop = {
      enable = true;
      settings = {
        appBadge = false;
        arRPC = true;
          staticTitle = true;
            hardwareAcceleration = true;
            discordBranch = "stable"; 
              checkUpdates = false;
            customTitleBar = false;
            disableMinSize = true;
            minimizeToTray = false;
             tray = false;
        };
      vencord = {
        settings = {
            autoUpdate = false;
            autoUpdateNotification = false;
            notifyAboutUpdates = false;
            themeLinks = ["https://refact0r.github.io/system24/build/system24.css"
            ];
            useQuickCss = true;
            disableMinSize = true;
            plugins = {
                FakeNitro.enabled = true;
            };
        };
      };
    };
}
