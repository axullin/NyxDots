{
  flake.modules.nixos.core =
    { inputs, ... }:
    {
      nixpkgs = {
        config = {
          allowUnfree = true;
        };
        overlays = builtins.attrValues inputs.self.overlays;
      };
    };
}
