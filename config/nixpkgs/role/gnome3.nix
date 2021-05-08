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
    # POP!_OS shell tiling extensions for Gnome 3
    # TODO(eliza): replace local package with upstream nixpkgs when
    # https://github.com/NixOS/nixpkgs/pull/104160 merges
    (pkgs.callPackage ../pkgs/pop_os_shell { })
  ];
in {
  home.packages = with pkgs;
    [
      # useful for testing webcams, etc
      gnome3.cheese
      # A tool to customize advanced GNOME 3 options
      gnome3.gnome-tweak-tool
      # KDE breeze-like Gnome UI theme
      gnome-breeze
      # A nice way to view information about use of system resources, like memory
      # and disk space
      gnome-usage
    ] ++ gnome_extensions;
  # services = {
  #   # necessary for `programs.firefox.enableGnomeExtensions` i guess?
  #   gnome3.chrome-gnome-shell.enable = true;
  # };
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-wayland;
    enableGnomeExtensions = true;
  };
}
