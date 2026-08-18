{
  flake.modules.nixos.networking =
    {
      config,
      lib,
      ...
    }:
    {
      programs.ssh.startAgent = true;

      services.openssh = {
        enable = true;
        allowSFTP = true;
        startWhenNeeded = true;
        ports = [ 22 ];

        hostKeys = [
          {
            path = "${lib.optionalString config.nyx.boot.impermanence.enable "/persist"}/etc/ssh/ssh_host_ed25519_key";
            type = "ed25519";
          }
        ];

        settings = {
          PermitRootLogin = "no";
          PasswordAuthentication = false;
          KbdInteractiveAuthentication = false;
          AuthenticationMethods = "publickey";
          PubkeyAuthentication = "yes";
          X11Forwarding = false;
          UsePAM = false;
          UseDns = false;
        };
      };
    };
}
