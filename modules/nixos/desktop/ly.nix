{
  flake.modules.nixos.desktop = {
    services.displayManager = {
      ly = {
        enable = true;
        settings = {
          session_log = "null";
          clear_password = true;
          allow_empty_password = true;
          hide_key_hints = true;
          hide_keyboard_locks = true;
          hide_version_string = true;
          xinitrc = null;
          hide_borders = true;
        };
      };
    };
  };
}
