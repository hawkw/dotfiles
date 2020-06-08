{ config, pkgs, ... }:

{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs;
    let
      unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
    in [

      # fonts
      iosevka
      unstable.cozette
      #   cherry

    ];
}
