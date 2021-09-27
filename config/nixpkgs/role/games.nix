{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    minecraft
    (callPackage ../pkgs/technic-launcher.nix { })
    (callPackage ../pkgs/ckan-1_29.nix { })
    playonlinux
  ];
}
