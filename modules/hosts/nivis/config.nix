{ config, ... }:
{
  flake.modules.nixos.nivis =
    {
      pkgs,
      hostName,
      userName,
      ...
    }:
    {
      imports = with config.flake.modules.nixos; [
        boot
        desktop
        gaming
        hardware
        networking
        virtualisation
      ];

      nyx = {
        desktop = {
          hyprland.enable = true;
        };

        boot = {
          cachyosKernel.enable = true;
          secure-boot.enable = true;

          impermanence = {
            enable = true;

            files = [
              "/etc/machine-id"
              "/etc/ly/save.txt"
            ];

            home = {
              directories = [
                ".local/share/keyrings"
                ".config/nixos"
                ".config/anki"
                ".local/share/Anki2"
                ".config/dconf"
                ".config/obsidian"
                ".config/BraveSoftware"
                ".config/zen"
                ".config/discord"
                ".config/Vencord"
                ".steam"
                ".cursor"
                ".config/cursor"
                ".local/share/Steam"
                ".local/share/osu"
                ".local/share/Celeste"
                ".local/share/PrismLauncher"
                ".config/Olympus"
                ".local/share/krita"
                ".config/obs-studio"
                ".config/OpenTabletDriver"
                ".config/wootility"
                ".cache/spotify-player"
                ".local/share/fish"
                ".cache/awww"
                ".config/noctalia"
                ".local/share/noctalia"
                ".local/state/noctalia"
                ".config/kotofetch"
                ".config/gh"
                ".local/share/nvim"
                ".local/state/nvim"
                ".claude"
              ];

              files = [
                ".claude.json"
              ];
            };
          };
        };

        networking.mc-server.enable = true;
      };

      networking = {
        hostName = hostName;
        networkmanager.enable = true;
        firewall.enable = false;
      };

      fileSystems."/mnt/storage" = {
        device = "/dev/disk/by-uuid/26dd8624-a605-7944-9671-99dcd58f79fc";
        fsType = "btrfs";
        options = [
          "noatime"
          "compress=zstd"
          "nofail"
        ];
      };

      system.stateVersion = "25.11";
    };
}
