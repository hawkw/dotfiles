# kubernetes`
{ config, pkgs, lib, home, ... }:

{
  home.packages = with pkgs; [
    kubectl
    kubespy
    # kube3d
    k3d
    kubectx
    kubelogin
    azure-cli
    k9s
    stern
    kubernetes-helm
    step-cli
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
