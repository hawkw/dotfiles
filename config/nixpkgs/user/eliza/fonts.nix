{ config, pkgs, ... }:

{
  fonts.fontconfig.enable = true;

  # fonts
  home.packages = with pkgs; [
    # nice monospace and bitmap fonts
    iosevka
    cozette
    tamzen

    # some nice ui fonts
    roboto
    inter-ui
    inter
    b612 # designed by Airbus for jet cockpit UIs!

    # noto, and friends --- manish says its good
    # this fixes unicode tofu, even if you don't actually use
    # noto as a UI font...
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    noto-fonts-extra
  ];

  #  Font configuration for alacritty (changes require restart)
  programs.alacritty.settings.font = {
    # TamzenForPowerline-14
    # Point size of the font
    size = 14;
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
