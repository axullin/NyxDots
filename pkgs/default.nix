{ pkgs, ... }:

{
  # Custom packages
  # default = pkgs.callPackage ./default { };

  # Minecraft mods
  nivel-modpack = pkgs.callPackage ./minecraft/modpack { };
  vanillatweaks = pkgs.callPackage ./minecraft/vanillatweaks { };
}
