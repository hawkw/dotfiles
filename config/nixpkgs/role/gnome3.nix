{ config, pkgs, lib, ... }:

let
  # configure installed Gnome 3 extensions
  # note: these have to be *enabled* manually in the gnome extensions UI...
  gnome_extensions = with pkgs.gnomeExtensions; [
    # a nicer application menu for gnome
    # gnomeExtensions.arc-menu
    # displays system status in the gnome-shell status bar
    system-monitor
    # displays system temperatures, fan RPMs, and voltages
    # freon
    # allows selecting the sound output device in the sound menu
    sound-output-device-chooser
    zfs-status-monitor
    # POP!_OS shell tiling extensions for Gnome 3
    # TODO(eliza): replace local package with upstream nixpkgs when
    # https://github.com/NixOS/nixpkgs/pull/104160 merges
    (pkgs.callPackage ../pkgs/pop_os_shell { })
    # POP!_OS Cosmic Dock
    (pkgs.callPackage ../pkgs/cosmic_dock.nix { })
  ];
  # configure Gnome themes
  themes = with pkgs; [
    ant-theme
    ant-nebula-theme
    dracula-theme
    arc-theme
    arc-icon-theme
    equilux-theme
    (pkgs.callPackage ../pkgs/pop_gtk_theme.nix { })
    pop-icon-theme
    qogir-theme
    yaru-theme
    matcha-gtk-theme
  ];
in {
  home.packages = with pkgs;
    [
      # useful for testing webcams, etc
      gnome3.cheese
      # A tool to customize advanced GNOME 3 options
      gnome3.gnome-tweaks
      # A nice way to view information about use of system resources, like memory
      # and disk space
      gnome-usage
      # (pkgs.callPackage ../pkgs/pop_desktop_widget.nix { })
    ] ++ gnome_extensions ++ themes;

  programs.firefox = {
    enable = true;
    package = pkgs.firefox-wayland;
  };

  #### gnome-keyring ########################################################
  services.gnome-keyring = {
    enable = true;
    components = [ "pkcs11" "secrets" "ssh" ];
  };
  programs.ssh.enable = true;
}
