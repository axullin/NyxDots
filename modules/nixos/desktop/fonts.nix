{
  flake.modules.nixos.desktop =
    { pkgs, ... }:
    {
      fonts.packages = with pkgs; [
        nerd-fonts.jetbrains-mono
        terminus_font
        noto-fonts
        nerd-fonts.fira-code
        nerd-fonts.iosevka
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
        roboto
        garamond-libre
      ];
    };
}
