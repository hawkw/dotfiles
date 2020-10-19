{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    kdeApplications.spectacle
    libsForQt5.qtstyleplugin-kvantum
  ];

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "us";
    # xkbOptions = "eurosign:e";

    # Enable touchpad support.
    # libinput.enable = true;

    # Enable the KDE Desktop Environment.
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;
  };
}
