{ config, lib, pkgs, ... }:

{
  imports = [
    ../common.nix
    ../roles/zsh.nix
    ../roles/kde.nix
    ../filesystems/noctis.nix
  ];

  networking = {
    hostName = "noctis"; # Define your hostname.
    hostId = "FADEFACE";
  };

  environment.systemPackages =
    let unstable = import <nixos-unstable> { config = config.nixpkgs.config; };
    in [ unstable.openrgb ];
}
