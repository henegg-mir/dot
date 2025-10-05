{
    programs.nixcord = {
      enable = true;
      discord.enable = false;
      vesktop.enable = true;
      config.themeLinks = [
        "https://refact0r.github.io/system24/build/system24.css"
      ];
    };
}