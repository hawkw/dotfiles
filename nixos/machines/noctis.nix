{ config, lib, pkgs, ... }:

{
  imports = [
    ../common.nix
    ../roles/zsh.nix
    ../roles/kde.nix
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
    # without dconf you can't change settings in gnome-terminal, so you are
    # stuck with extremely broken font rendering. this is because gnome is
    # extremely well designed.
    dconf.enable = true;
    # Used specifically for its (quite magical) "copy as html" function.
    gnome-terminal.enable = true;
    # enable the correct perf tools for this kernel version
    perftools.enable = true;
  };
}
