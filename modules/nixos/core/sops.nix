{
  flake.modules.nixos.core =
    {
      config,
      pkgs,
      inputs,
      ...
    }:
    {
      imports = [ inputs.sops-nix.nixosModules.sops ];
    };
}
