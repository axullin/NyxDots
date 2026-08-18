{
  flake.modules.homeManager.desktop = {
    programs.cava = {
      enable = true;
      settings = {

        general = {
          bars = 0;
        };

        input = {
          method = "pipewire";
        };

        smoothing = { };
      };
    };
  };
}
