{
  flake.modules.homeManager.terminal =
  { pkgs, inputs, ... }: 
  {
    imports = [ inputs.fetch.homeManagerModules.default ];
    
    programs.fetch = {
      enable = true;
      labelColor = "blue";
      info = [
        "os"
        "kernel"
        "shell"
        "wm"
        "cpu"
        "gpu"
        "display"
        "uptime"
      ];
      speed = 1.0;
      spin = "xy";
    };
  };
}
