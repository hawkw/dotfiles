# kubernetes`
{ config, pkgs, lib, ... }:

{
  home.packages = let
    unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
  in with pkgs; [
    kubectl
    kubespy
    unstable.kube3d
    kubectx
    k9s
    stern
    kubernetes-helm
  ];

  programs.zsh = {
    shellAliases = { k = "kubectl"; };
    initExtra = ''
      # Import all docker images matching a glob into k3d.
      function k3d-import-all() {
          docker images "$1" --format "{{.Repository}}:{{.Tag}}" | xargs k3d image import
      }
    '';
  };
}
