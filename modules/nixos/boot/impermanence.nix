{
  flake.modules.nixos.boot =
    {
      config,
      lib,
      userName,
      inputs,
      ...
    }:
    let
      cfg = config.nyx.boot;
    in
    {
      imports = [ inputs.impermanence.nixosModules.impermanence ];

      options.nyx.boot.impermanence = {
        enable = lib.mkEnableOption "Enable impermanence";

        directories = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [ ];
        };

        files = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [ ];
        };
      };

      options.nyx.boot.impermanence.home = {
        directories = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [ ];
        };

        files = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [ ];
        };
      };

      config = lib.mkIf cfg.impermanence.enable {
        programs.fuse.userAllowOther = true;
        fileSystems."/persist".neededForBoot = true;
        environment.persistence."/persist" = {
          hideMounts = true;
          directories = [
            "/var/log"
            "/var/lib"
            "/etc/NetworkManager/system-connections"
          ]
          ++ cfg.impermanence.directories;

          files = [
            "/etc/ssh/ssh_host_ed25519_key"
            "/etc/ssh/ssh_host_ed25519_key.pub"
            "/etc/ssh/ssh_host_rsa_key"
            "/etc/ssh/ssh_host_rsa_key.pub"
          ]
          ++ cfg.impermanence.files;
        };

        home-manager.users.${userName} = {
          home.persistence."/persist" = {
            hideMounts = true;
            directories = [
              "Downloads"
              "Music"
              "Wallpapers"
              "Documents"
              "Videos"
              "Projects"
              "Pictures"
              "Notes"
              ".ssh"
            ]
            ++ cfg.impermanence.home.directories;

            files = cfg.impermanence.home.files;
          };
        };
      };
    };
}
