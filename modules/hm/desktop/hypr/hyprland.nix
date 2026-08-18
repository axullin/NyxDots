{
  flake.modules.homeManager.desktop =
    { lib, config, ... }:
    let
      cfg = config.nyx.desktop.hyprland;
    in
    {
      config = lib.mkIf cfg.enable {
        wayland.windowManager.hyprland = {
          enable = true;
          xwayland.enable = true;
          configType = "lua";

          extraLuaFiles.config = ''
            -- ══════════════════════════════════════ VARIABLES ══════════════════════════════════════

            local mod = "SUPER"
            local terminal = "kitty"
            local launcher = "rofi -show drun"

            -- ══════════════════════════════════════ DISPLAY ════════════════════════════════════════

            hl.monitor({ output = "DP-1", mode = "2560x1440@360", position = "auto", scale = 1 })

            -- 110 DPI panel: no compositor scaling, size is recovered via font DPI instead.
            -- Must be hl.env — home.sessionVariables don't reach keybind-launched apps.
            hl.env("QT_FONT_DPI", "128")
            hl.env("XCURSOR_THEME", "Bibata-Original-Classic")
            hl.env("XCURSOR_SIZE", "28")

            -- ══════════════════════════════════════ SETTINGS ═══════════════════════════════════════

            hl.config({
              general = {
                gaps_in = 8, 
                gaps_out = 10,
                border_size = 0,
                ["col.active_border"] = "rgba(b2b2b2ff)",
                ["col.inactive_border"] = "rgba(00000000)",
                layout = "dwindle",
                allow_tearing = true,
              },
              decoration = {
                active_opacity = 1.0,
                inactive_opacity = 1.0,
                rounding = 5,
                shadow = {
                  enabled = true 
                },
                blur = {
                  enabled = true,
                  size = 3,
                  passes = 3,
                  new_optimizations = true,
                },
              },
              input = {
                kb_layout = "pl",
                follow_mouse = 1,
                accel_profile = "flat",
                force_no_accel = true,
                sensitivity = 0,
                repeat_rate = 30,
                repeat_delay = 300,
              },
              misc = {
                force_default_wallpaper = 0,
                disable_hyprland_logo = true,
                vrr = 0,
              },
              cursor = {
                enable_hyprcursor = false,
                no_hardware_cursors = true,
              },
              xwayland = {
                force_zero_scaling = false,
              },
              debug = {
                vfr = false,
              },
              animations = {
                enabled = true,
              },
            })

            -- ══════════════════════════════════════ ANIMATIONS ═════════════════════════════════════

            hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })

            hl.animation({ leaf = "windows",    enabled = true, speed = 3, bezier = "easeOutQuint" })
            hl.animation({ leaf = "layers",     enabled = true, speed = 2, bezier = "default", style = "fade" })
            hl.animation({ leaf = "border",     enabled = true, speed = 5, bezier = "default" })
            hl.animation({ leaf = "fade",       enabled = true, speed = 3, bezier = "default" })
            hl.animation({ leaf = "workspaces", enabled = true, speed = 3, bezier = "default", style = "slide" })

            -- ══════════════════════════════════════ STARTUP ════════════════════════════════════════

            hl.on("hyprland.start", function()
              hl.exec_cmd("awww-daemon")
            end)

            -- ══════════════════════════════════════ WINDOW RULES ═══════════════════════════════════


            -- ══════════════════════════════════════ BINDS ══════════════════════════════════════════

            -- Focus
            hl.bind(mod .. " + H", hl.dsp.focus({ direction = "left" }))
            hl.bind(mod .. " + L", hl.dsp.focus({ direction = "right" }))
            hl.bind(mod .. " + K", hl.dsp.focus({ direction = "up" }))
            hl.bind(mod .. " + J", hl.dsp.focus({ direction = "down" }))

            -- Move window
            hl.bind(mod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
            hl.bind(mod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
            hl.bind(mod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
            hl.bind(mod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))

            -- Apps
            hl.bind(mod .. " + Q", hl.dsp.exec_cmd(terminal))
            hl.bind(mod .. " + D", hl.dsp.exec_cmd(launcher))

            -- Window actions
            hl.bind(mod .. " + C", hl.dsp.window.close())
            hl.bind(mod .. " + V", hl.dsp.window.float({ action = "toggle" }))
            hl.bind(mod .. " + F", hl.dsp.window.fullscreen())

            -- Session
            hl.bind(mod .. " + Escape", hl.dsp.exec_cmd("loginctl lock-session"))

            -- Workspaces
            for i = 1, 10 do
              local key = tostring(i % 10)
              hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
              hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
            end

            -- Special workspaces
            hl.bind(mod .. " + M", hl.dsp.workspace.toggle_special("music"))
            hl.workspace_rule({ workspace = "special:music", on_created_empty = "kitty -e spotify_player" })

            -- Resize active window
            hl.bind(mod .. " + equal", hl.dsp.window.resize({ x = 40, y = 0, relative = true }), { repeating = true })
            hl.bind(mod .. " + minus", hl.dsp.window.resize({ x = -40, y = 0, relative = true }), { repeating = true })

            -- Mouse
            hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
            hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

            -- Volume / mic
            hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 1%+"), { locked = true, repeating = true })
            hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-"), { locked = true, repeating = true })
            hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
            hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })

            -- Brightness
            hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 10%+"), { locked = true, repeating = true })
            hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"), { locked = true, repeating = true })

            -- Media
            hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
            hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
            hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
            hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
          '';
        };
      };
    };
}
