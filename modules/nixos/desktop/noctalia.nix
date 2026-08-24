{
  flake.modules.nixos.desktop =
    { pkgs, inputs, ... }:
    {
      imports = [ inputs.noctalia.nixosModules.default ];

      programs.noctalia = {
        package = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;
        recommendedServices.enable = true;
      };
    };
}
