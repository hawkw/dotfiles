{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    minecraft
    ckan
    (callPackage ../pkgs/technic-launcher.nix { })
  ];
}
