{ config, pkgs, lib, ... }:

with lib;
mkMerge [
  { }
  (mkIf (config.networking.hostName == "noctis") {
    inherit (import ./noctis.nix { })
    ;
  })
]
