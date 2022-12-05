{ config, pkgs, ... }:

{
  fonts.fontconfig.enable = true;

  # fonts
  home.packages = let
    # until https://github.com/NixOS/nixpkgs/issues/185633 is fixed
    iosevka = (import (pkgs.fetchFromGitHub {
      owner = "NixOS";
      repo = "nixpkgs";
      rev = "0d440c18119406feb8a32cd5ec2ff0b83fc9104b";
      sha256 = "sha256-Fw6zRNBonu9wwVSQ0Cj9zHliw6yChMQPf3GPQFJZ4us=";
    }) { }).iosevka;
  in with pkgs; [
    # nice monospace and bitmap fonts
    iosevka
    cozette
    tamzen
    # tamsyn
    nerdfonts
    # requires `input-fonts.acceptLicense = true` in `config.nix`.
    input-fonts

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
