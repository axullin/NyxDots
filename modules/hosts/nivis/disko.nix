{
  flake.modules.nixos.nivis =
    { inputs, ... }:
    {
      imports = [ inputs.disko.nixosModules.disko ];

      disko.devices = {
        disk = {
          # /boot — p4, vfat 1G
          boot = {
            device = "/dev/disk/by-id/nvme-Samsung_SSD_980_500GB_S64DNX1T225222X-part4";
            type = "disk";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [ "umask=0077" ];
            };
          };

          # swap — p5, 4G
          swap = {
            device = "/dev/disk/by-id/nvme-Samsung_SSD_980_500GB_S64DNX1T225222X-part5";
            type = "disk";
            content.type = "swap";
          };

          # NixOS btrfs — p6, 135G
          nixos = {
            device = "/dev/disk/by-id/nvme-Samsung_SSD_980_500GB_S64DNX1T225222X-part6";
            type = "disk";
            content = {
              type = "btrfs";
              extraArgs = [
                "-f"
                "--label"
                "nixos"
              ];
              subvolumes = {
                "@nix" = {
                  mountpoint = "/nix";
                  mountOptions = [
                    "compress=zstd"
                    "noatime"
                  ];
                };
                "@persist" = {
                  mountpoint = "/persist";
                  mountOptions = [
                    "compress=zstd"
                    "noatime"
                  ];
                };
              };
            };
          };
        };

        # Ephemeral root — wiped on every reboot
        nodev."/" = {
          fsType = "tmpfs";
          mountOptions = [
            "defaults"
            "size=16G"
            "mode=755"
          ];
        };
      };
    };
}
