{
  flake.modules.nixos.nivis =
    { pkgs, userName, ... }:
    {
      environment.systemPackages = with pkgs; [
        godot
      ];

      home-manager.users.${userName} = {
        home.packages = with pkgs; [
          # browser
          brave
          tmux

          # editors & dev
          claude-code
          cursor-cli
          reaper

          # cli
          agent-browser
          ast-grep
          btop
          jq
          tree
          unzip
          yazi
          zip

          # media & graphics
          ffmpeg
          obsidian
          krita
          celluloid
          aseprite

          # audio & hardware
          brightnessctl
          pavucontrol
          playerctl
          wireplumber
          audacity

          # chat
          whatsapp-electron

          # gaming
          prismlauncher
          (olympus.override {
            celesteWrapper = "steam-run";
          })

          # terminal
          catnip
          kotofetch
          terminal-rain-lightning
          tty-clock
        ];
      };
    };
}
