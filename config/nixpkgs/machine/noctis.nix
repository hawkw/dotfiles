{ config, pkgs, lib, ... }:

let systemConfig = (import <nixpkgs/nixos> { }).config;
in lib.mkIf (systemConfig.networking.hostname == "noctis")
(builtins.trace [ "making config for noctis" systemConfig ] {

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
      enableZshIntegration = true;
      enableXsessionIntegration = true;
      keys = [ "id_ed25519" ];
    };
  };
})
