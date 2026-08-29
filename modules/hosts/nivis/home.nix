{ config, ... }:
{
  flake.modules.homeManager.nivis =
    { userName, ... }:
    {
      imports = with config.flake.modules.homeManager; [
        desktop
      ];

      nyx.desktop.hyprland.enable = true;
      nyx.desktop.noctalia.enable = true;

      home.stateVersion = "26.05";
    };
}
