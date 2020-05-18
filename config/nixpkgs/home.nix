{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.03";

  # Packages managed by Home Manager
  home.packages = [ pkgs.vscode ];

  programs.vscode = {
    enable = true;
    extensions = (with pkgs.vscode-extensions; [
      bbenoist.Nix
      # ms-azuretools.vscode-docker
      ms-vscode-remote.remote-ssh
    ]);
  };

}
