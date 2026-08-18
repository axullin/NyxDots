{
  inputs,
  config,
  ...
}:
let
  hostName = "nivis";
  userName = "axullin";
  userEmail = "axul.full@gmail.com";
  system = "x86_64-linux";
  unstable = true;
  nixpkgs = if unstable then inputs.nixpkgs else inputs.nixpkgs-stable;
in
{
  flake.nixosConfigurations."${hostName}" = nixpkgs.lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit
        inputs
        hostName
        userName
        userEmail
        system
        ;
    };
    modules = [
      config.flake.modules.nixos.core
      config.flake.modules.nixos.${hostName}
    ];
  };
}
