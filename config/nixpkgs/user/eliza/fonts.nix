{ config, pkgs, ... }:

{
  fonts.fontconfig.enable = true;

  home.packages = let
    unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
  in with unstable; [
    # fonts
    iosevka
    cozette
    roboto
    tamzen
    # noto, and friends --- manish says its good
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    noto-fonts-extra
  ];

  #  Font configuration for alacritty (changes require restart)
  programs.alacritty.settings.font = {
    # TamzenForPowerline-14
    # Point size of the font
    size = 12;
    # The normal (roman) font face to use.
    normal = {
      family = "Iosevka";
      style = "Regular";
    };

    bold = {
      family = "Iosevka";
      style = "Bold";
    };

    italic = {
      family = "Iosevka";
      style = "Italic";
    };
  };
}
