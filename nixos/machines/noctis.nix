{ config, lib, pkgs, ... }:

{
  imports = [
    ../common.nix
    # role-based configurations
    ../roles/zsh.nix
    ../roles/gnome3.nix
    ../roles/games.nix
    ../roles/perftools.nix
    # local packages
    ../pkgs/logiops/logid.nix
    ../pkgs/openrgb.nix
    # filesystems for this machine
    ../filesystems/noctis.nix
  ];

  networking = {
    hostName = "noctis"; # Define your hostname.
    hostId = "FADEFACE";
  };

  ## HAHA LOL GNOME BULLSHIT
  programs = {
    # Used specifically for its (quite magical) "copy as html" function.
    gnome-terminal.enable = true;
    # enable the correct perf tools for this kernel version
    perftools.enable = true;
    openrgb.enable = true;
  };

  services = {
    openrgb.enable = true;
    # logid.enable = true;
  };

  ### pipewire ###
  # don't use the default `sound` config (alsa)
  sound.enable = false;
  # Use PipeWire as the system audio/video bus
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    jack.enable = true;
    pulse.enable = true;
    socketActivation = true;
  };

  ### enable flakes ###
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
}
