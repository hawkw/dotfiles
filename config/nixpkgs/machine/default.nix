{ config, pkgs, lib, ... }:

{
  # To add new per-machine configs, add a new config file with a `mkIf` here
  # similar to the one in `noctis.nix`.
  # Then, those configs will be applied only if the hostname matches the new
  # machine's hostname.
  imports = [ ./noctis.nix ];
}
