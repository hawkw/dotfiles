# Configuration for Visual Studio Code
{ config, lib, pkgs, ... }:

{
  imports = [
    "${
      fetchTarball "https://github.com/msteen/nixos-vsliveshare/tarball/master"
    }/modules/vsliveshare/home.nix"
  ];

  home.packages = with pkgs; [
    vscode
    nodejs-12_x # required for vscode remote ssh
  ];

  # enable VS Code Liveshare
  services.vsliveshare = {
    enable = true;
    extensionsDir = "$HOME/.vscode/extensions";
    nixpkgs = fetchTarball
      "https://github.com/NixOS/nixpkgs/tarball/61cc1f0dc07c2f786e0acfd07444548486f4153b";
  };
}
