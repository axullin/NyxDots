{
  flake.modules.nixos.boot =
    {
      config,
      lib,
      inputs,
      pkgs,
      ...
    }:
    let
      cfg = config.nyx.boot;
    in
    {
      imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];

      options.nyx.boot.secure-boot = {
        enable = lib.mkEnableOption "Enable secure boot";
      };

      config = lib.mkIf cfg.secure-boot.enable {
        environment.systemPackages = [ pkgs.sbctl ];

        boot.loader.systemd-boot = {
          enable = lib.mkForce false;
          consoleMode = "max";
        };

        boot.lanzaboote = {
          enable = true;
          autoGenerateKeys.enable = true;
          autoEnrollKeys.enable = true;

          configurationLimit = 10;
          pkiBundle = "/var/lib/sbctl";
        };
      };
    };
}
