{ config, pkgs, lib, ... }:

{
  packages = with pkgs; [ python39Packages.pip ];
}
