{ config, pkgs, lib, ... }:

{
  imports = [ ../role/games.nix ../role/k8s.nix ../role/gnome3.nix ];
  home.packages = with pkgs; [ lm_sensors wally-cli conky ];
  # roles = { games.enable = true; };
  #############################################################################
  ## Services                                                                 #
  #############################################################################
  services = {
    gpg-agent = {
      enable = true;
      pinentryFlavor = "gnome3";
    };
    kbfs.enable = true;
    keybase.enable = true;
  };

  #############################################################################
  ## Programs                                                                 #
  #############################################################################
  programs = {
    keychain = {
      enable = true;
      enableXsessionIntegration = true;
      keys = [ "id_ed25519" ];
    };
    # gnome-terminal.enable = true;
    # dconf.enable = true;
  };
}
