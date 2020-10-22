{ config, pkgs, lib, ... }:

{
  imports = [ ../role/games.nix ../role/k8s.nix ];
  home.packages = with pkgs; [ lm_sensors wally-cli ];

  #############################################################################
  ## Services                                                                 #
  #############################################################################
  services = {
    gpg-agent = { enable = true; };
    kbfs.enable = true;
    keybase.enable = true;
    gnome-keyring.enable = true;
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
  };
}
