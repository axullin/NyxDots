{
  flake.modules.homeManager.desktop =
    { inputs, ... }:
    {
      imports = [ inputs.nixcord.homeModules.nixcord ];

      programs.nixcord = {
        enable = true;
        discord.vencord.enable = true;
        vesktop.enable = false;
        dorion.enable = false;
        config = {
          themeLinks = [ ];
          frameless = true;
          plugins = {
            hideMedia.enable = true;
            ignoreActivities = {
              enable = true;
              ignorePlaying = true;
              ignoreWatching = true;
            };
          };
        };
      };
    };
}
