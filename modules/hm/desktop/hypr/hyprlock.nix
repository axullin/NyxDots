{
  flake.modules.homeManager.desktop =
    {
      pkgs,
      config,
      lib,
      ...
    }:
    let
      cfg = config.nyx.desktop.hyprland;

      accent = "rgba(b2b2b2ff)";
      text = "rgba(e6e6e6ff)";
      subtext = "rgba(9a9a9aff)";
      inputBg = "rgba(000000aa)";

      wallpaper = ../../../../assets/wallpapers/waterfall.png;

      serif = "Garamond Libre";
      mono = "JetBrainsMono Nerd Font";

      nowPlaying = pkgs.writeShellScript "hyprlock-now-playing" ''
        case "$(${pkgs.playerctl}/bin/playerctl status 2>/dev/null)" in
          Playing | Paused)
            ${pkgs.playerctl}/bin/playerctl metadata --format '<b>{{markup_escape(artist)}}   {{markup_escape(title)}}</b>' 2>/dev/null
            ;;
        esac
      '';
    in
    {
      config = lib.mkIf cfg.enable {
        programs.hyprlock = {
          enable = true;
          settings = {
            general = {
              hide_cursor = true;
              grace = 0;
              disable_loading_bar = true;
              ignore_empty_input = true;
            };

            background = [
              {
                monitor = "";
                path = "${wallpaper}";
                blur_size = 4;
                blur_passes = 3;
                noise = 0.01;
                contrast = 1.3;
                brightness = 0.4;
                vibrancy = 0.21;
                vibrancy_darkness = 0.0;
              }
            ];

            input-field = [
              {
                monitor = "";
                size = "250, 50";
                outline_thickness = 3;
                dots_size = 0.26;
                dots_spacing = 0.64;
                dots_center = true;
                dots_rounding = -1;
                rounding = 22;
                outer_color = inputBg;
                inner_color = inputBg;
                font_color = text;
                fade_on_empty = true;
                placeholder_text = "<i>Password...</i>";
                position = "0, 120";
                halign = "center";
                valign = "bottom";
              }
            ];

            label = [
              # Hours
              {
                monitor = "";
                text = ''cmd[update:1000] echo "<b><big> $(date +"%H") </big></b>"'';
                color = text;
                font_size = 128;
                font_family = serif;
                shadow_passes = 3;
                shadow_size = 4;
                position = "0, 220";
                halign = "center";
                valign = "center";
              }
              # Minutes
              {
                monitor = "";
                text = ''cmd[update:1000] echo "<b><big> $(date +"%M") </big></b>"'';
                color = text;
                font_size = 128;
                font_family = serif;
                shadow_passes = 3;
                shadow_size = 4;
                position = "0, 80";
                halign = "center";
                valign = "center";
              }
              # Weekday
              {
                monitor = "";
                text = ''cmd[update:18000000] echo "<b><big> $(date +'%A') </big></b>"'';
                color = subtext;
                font_size = 22;
                font_family = mono;
                position = "0, 0";
                halign = "center";
                valign = "center";
              }
              # Date
              {
                monitor = "";
                text = ''cmd[update:18000000] echo "<b> $(date +'%d %b') </b>"'';
                color = subtext;
                font_size = 18;
                font_family = mono;
                position = "0, -30";
                halign = "center";
                valign = "center";
              }
              # Weather
              {
                monitor = "";
                text = ''cmd[update:18000000] echo "<b>Feels like<big> $(${pkgs.curl}/bin/curl -s 'wttr.in?format=%t' | tr -d '+') </big></b>"'';
                color = subtext;
                font_size = 18;
                font_family = serif;
                position = "0, 55";
                halign = "center";
                valign = "bottom";
              }
              # Now playing
              {
                monitor = "";
                text = "cmd[update:1000] ${nowPlaying}";
                color = accent;
                font_size = 18;
                font_family = mono;
                shadow_passes = 3;
                shadow_size = 1;
                position = "0, 20";
                halign = "center";
                valign = "bottom";
              }
            ];
          };
        };
      };
    };
}
