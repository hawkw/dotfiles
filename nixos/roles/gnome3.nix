{ config, lib, pkgs, ... }:

{
  services = {
    xserver = {
      enable = true;
      layout = "us";
      displayManager.gdm.enable = true;
      displayManager.gdm.wayland = true;
      desktopManager.gnome.enable = true;
      displayManager.defaultSession = "gnome";
    };
    dbus.packages = [ pkgs.gnome3.dconf ];
    udev.packages = [ pkgs.gnome3.gnome-settings-daemon ];

    # Enable gnome3 components
    gnome = {
      # Sushi, a quick previewer for Nautilus
      sushi.enable = true;
    };
  };

  environment.systemPackages = [ pkgs.firefox-wayland ];

  programs = {
    # gpaste, a clipboard manager for Gnome
    gpaste.enable = true;
  };

  ### gnome-keyring #########################################################
  # enable the Gnome keyring
  services.gnome.gnome-keyring.enable = true;
  # enable gnome keyring unlock on login
  security.pam.services = { login.enableGnomeKeyring = true; };
}
