{
  flake.modules.nixos.core =
    {
      config,
      userName,
      ...
    }:
    {
      programs.nh = {
        enable = true;

        clean = {
          enable = true;
          dates = "weekly";
          extraArgs = "--keep 10";
        };

        flake = "/home/${userName}/.config/nixos";
      };
    };
}
