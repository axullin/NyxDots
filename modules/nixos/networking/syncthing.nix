{
  flake.modules.nixos.networking =
    { userName, ... }:
    {
      systemd.services.syncthing.unitConfig.RequiresMountsFor = "/home/${userName}/Notes";

      services.syncthing = {
        enable = true;
        user = userName;
        group = "users";
        openDefaultPorts = true;
        overrideDevices = true;
        overrideFolders = true;

        settings = {
          options.urAccepted = -1;

          devices = {
            S20-phone = {
              id = "3HZR25A-X6EYJTU-UXRIEZX-WXBCXGR-NODFE3W-KKDZGU4-C6IHIWA-UYNTIQI";
              name = "S20-phone";
            };
          };

          folders = {
            notes = {
              id = "notes";
              label = "Notes";
              path = "/home/${userName}/Notes";
              devices = [ "S20-phone" ];
              versioning = {
                type = "trashcan";
                params.cleanoutDays = "30";
              };
            };
          };
        };
      };
    };
}
