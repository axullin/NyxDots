{
  flake.modules.homeManager.desktop =
    {
      pkgs,
      lib,
      config,
      inputs,
      ...
    }:
    let
      cfg = config.nyx.desktop.noctalia;
    in
    {
      options.nyx.desktop.noctalia = {
        enable = lib.mkEnableOption "the Noctalia desktop shell";

        theme.mode = lib.mkOption {
          type = lib.types.enum [
            "dark"
            "light"
          ];
          default = "dark";
          description = "Noctalia theme mode.";
        };

        bar.position = lib.mkOption {
          type = lib.types.enum [
            "top"
            "bottom"
            "left"
            "right"
          ];
          default = "top";
          description = "Noctalia bar position.";
        };
      };

      imports = [ inputs.noctalia.homeModules.default ];

      config = lib.mkIf cfg.enable {
        programs.noctalia = {
          enable = true;
          package = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;
          systemd.enable = true;
          settings = {
            theme.mode = cfg.theme.mode;
            bar.position = cfg.bar.position;
          };
        };
      };
    };
}
