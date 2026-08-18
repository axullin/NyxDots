{
  flake.modules.nixos.gaming =
    { pkgs, ... }:
    {
      hardware.wooting.enable = true;

      hardware.opentabletdriver.enable = true;
      hardware.uinput.enable = true;

      environment.systemPackages = with pkgs; [
        osu-lazer-bin
      ];
    };
}
