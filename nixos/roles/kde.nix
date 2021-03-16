{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    spectacle
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

  # It's necessary to enable Gnome keyring to make VS Code happy...
  services.gnome3.gnome-keyring.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;
}
