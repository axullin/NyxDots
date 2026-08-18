{
  flake.modules.nixos.desktop =
    { pkgs, ... }:
    {
      programs.hyprland = {
        enable = true;
        package = pkgs.hyprland-git.hyprland;
        portalPackage = pkgs.hyprland-git.xdg-desktop-portal-hyprland;
      };

      xdg.portal = {
        extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
        config.common = {
          default = [ "gtk" ];
          "org.freedesktop.impl.portal.Screenshot" = [ "hyprland" ];
          "org.freedesktop.impl.portal.ScreenCast" = [ "hyprland" ];
        };
      };

      xdg.terminal-exec = {
        enable = true;
        settings.default = [ "kitty.desktop" ];
      };
    };
}
