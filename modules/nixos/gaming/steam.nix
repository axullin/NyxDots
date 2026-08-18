{
  flake.modules.nixos.gaming =
    { pkgs, ... }:
    {
      programs.steam = {
        enable = true;
        extraCompatPackages = [ pkgs.proton-ge-bin ];
      };

      hardware.graphics = {
        enable32Bit = true;
        enable = true;
      };
    };
}
