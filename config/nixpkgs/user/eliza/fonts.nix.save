{ config, pkgs, ... }:

{
  fonts.fontconfig.enable = true;

  home.packages = let
    unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
  in with unstable; [
    # fonts
    iosevka
    cozette
    # cherry
    roboto
    tamzen
  ];
}
