{ config, ... }:
{
  flake.modules.homeManager.nivis =
    { userName, ... }:
    {
      imports = with config.flake.modules.homeManager; [
        desktop
      ];

      nyx.desktop.hyprland.enable = true;
      nyx.desktop.noctalia = {
        enable = true;
        theme.mode = "dark";
        bar.position = "top";
      };

      home.stateVersion = "26.05";
    };
}
