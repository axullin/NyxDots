{
  flake.modules.homeManager.desktop =
    { pkgs, ... }:
    {
      programs.anki = {
        enable = true;
        theme = "dark";
        # unstable's anki 25.09.4 has no cached build and fails from source (uv can't
        # resolve iniconfig in the sandbox); stable ships the same version, prebuilt.
        package = pkgs.stable.anki;
        addons = [
          pkgs.stable.ankiAddons.anki-connect
          pkgs.stable.ankiAddons.passfail2
        ];
      };
    };
}
