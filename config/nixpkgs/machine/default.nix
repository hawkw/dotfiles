{ config, pkgs, lib, ... }:

{
  # Per-machine configs are added in `~/.machine.nix`. This can be a symlink to
  # another config file in this directory.
  # imports = let 
  #     path = ~/.machine.nix;
  #     exists = builtins.pathExists path; 
  #   in if exists then (builtins.trace "~/.machine.nix exists" [path]) 
  #   else (builtins.trace "~/.machine.nix does not exist" [ ]);
  imports = [ ./butterfly.nix ];
}
