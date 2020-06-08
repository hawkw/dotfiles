{ config, pkgs, lib, ... }:

with lib;
mkMerge [
  { }
  (mkIf (config.networking.hostName == "noctis") {
    inherit (import ./noctis.nix { })
    ;
  })
  # To add new per-machine configs, add a `mkIf` here similar to the one above.
  # Then, those configs will be applied only if the hostname matches the new
  # machine's hostname.
]
