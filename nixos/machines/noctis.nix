{ config, lib, pkgs, ... }:

{
  imports = [
    ../common.nix
    ../roles/zsh.nix
    ../roles/gnome3.nix
    ../roles/games.nix
    ../roles/perftools.nix
    ../filesystems/noctis.nix
  ];

  networking = {
    hostName = "noctis"; # Define your hostname.
    hostId = "FADEFACE";
  };

  environment.systemPackages =
    let unstable = import <nixos-unstable> { config = config.nixpkgs.config; };
    in with pkgs; [ unstable.openrgb ];

  ## HAHA LOL GNOME BULLSHIT
  programs = {
    # Used specifically for its (quite magical) "copy as html" function.
    gnome-terminal.enable = true;
    # enable the correct perf tools for this kernel version
    perftools.enable = true;
  };
}
