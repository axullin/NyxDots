{
  flake.modules.homeManager.desktop = {
    programs.kitty = {
      enable = true;
      settings = {
        cursor_shape = "beam";
        cursor_shape_unfocused = "beam";
        cursor_blink_interval = 2;
        editor = "nvim";
        scrollbar = "scrolled-and-hovered";
        scrollback_lines = 5000;
        repaint_delay = 5;
        input_delay = 1;
        enable_audio_bell = "no";
        foreground = "#cccccc";
        background = "#000000";
        background_opacity = "0.6";
        confirm_os_window_close = "0";
        window_padding_width = 0;
        window_margin_width = 0;
      };

      font = {
        name = "JetBrainsMono Nerd Font";
        size = 16;
      };
    };
  };
}
