{
  flake.modules.nixos.virtualisation =
    {
      config,
      lib,
      pkgs,
      userName,
      ...
    }:
    {
      virtualisation = {
        libvirtd = {
          enable = true;
          qemu = {
            swtpm.enable = true;
          };
        };
        spiceUSBRedirection.enable = true;
      };

      users.users.${userName}.extraGroups = [ "libvirtd" ];

      environment.systemPackages = with pkgs; [
        virt-manager
        virt-viewer
      ];
    };
}
