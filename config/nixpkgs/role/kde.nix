{ config, pkgs, lib, ... }:

{
  programs = {
    # enable gpaste, a gnome clipboard manager.
    gpaste.enable = true;
  };
}
