{ config, lib, pkgs, ... }:

{
  services = {
    xserver = {
      enable = true;
      layout = "us";
      displayManager.gdm.enable = true;
      displayManager.gdm.wayland = true;
      desktopManager.gnome3.enable = true;
      displayManager.defaultSession = "gnome";
    };
    dbus.packages = [ pkgs.gnome3.dconf ];
    udev.packages = [ pkgs.gnome3.gnome-settings-daemon ];

    # Enable gnome3 components
    gnome3 = {
      gnome-keyring.enable = true;
      # Sushi, a quick previewer for Nautilus
      sushi.enable = true;
    };
  };
  security.pam.services = { login.enableGnomeKeyring = true; };
  #   programs.gnupg.agent = {
  #     enable = true;
  #     enableSSHSupport = true;
  #     pinentryFlavor = "gnome3";
  #   };
  environment.systemPackages = [ pkgs.firefox-wayland ];
  programs = {
    # gpaste, a clipboard manager for Gnome
    gpaste.enable = true;
  };
}
