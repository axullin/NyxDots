{
  flake.modules.nixos.boot =
    {
      pkgs,
      config,
      lib,
      ...
    }:
    let
      cfg = config.nyx.boot;
    in
    {
      options.nyx.boot.grub = {
        enable = lib.mkEnableOption "Use GRUB instead of systemd-boot";
      };

      config = lib.mkMerge [
        {
          boot.loader = {
            timeout = 60;
            efi.canTouchEfiVariables = true;
          };
        }

        (lib.mkIf (!cfg.grub.enable && !cfg.secure-boot.enable) {
          boot.loader.systemd-boot = {
            enable = true;
            consoleMode = "max";
          };
        })

        (lib.mkIf cfg.grub.enable {
          environment.systemPackages = [ pkgs.os-prober ];

          boot.loader.grub = {
            enable = true;
            device = "nodev";
            configurationLimit = 10;
            efiSupport = true;
            useOSProber = true;
            splashImage = null;
            theme =
              pkgs.runCommand "ly-grub-theme"
                {
                  buildInputs = [ pkgs.grub2 ];
                }
                ''
                  mkdir -p $out
                  grub-mkfont -s 32 -o $out/terminus32.pf2 ${pkgs.terminus_font}/share/fonts/terminus/ter-u32b.otb

                  cat > $out/theme.txt <<EOF
                  desktop-color: "#000000"

                  + boot_menu {
                    left = 25%
                    top = 40%
                    width = 50%
                    height = 50%
                    item_font = "terminus32"
                    item_color = "#888888"
                    selected_item_color = "#ffffff"
                    item_spacing = 25
                    scrollbar = false
                    menu_pixmap_style = "none"
                  }

                  + label {
                    top = 0
                    left = 0
                    width = 0
                    height = 0
                    text = ""
                  }
                  EOF
                '';
          };
        })
      ];
    };
}
