{
  flake.modules.nixos.desktop =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    let
      cfg = config.nyx.desktop.hyprland;
    in
    {
      options.nyx.desktop.hyprland = {
        enable = lib.mkEnableOption "Enable Hyprland";
      };

      config = lib.mkIf cfg.enable {
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
    };
}
