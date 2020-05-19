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
  home.packages = with pkgs; [
    nixfmt
    direnv
    vscode
    rustup
  ];

  programs.vscode = {
    enable = true;
    extensions = (with pkgs.vscode-extensions; [
      # nix syntax highlighting
      bbenoist.Nix
      ms-vscode-remote.remote-ssh
      ms-azuretools.vscode-docker
      ms-kubernetes-tools.vscode-kubernetes-tools
      # wal colorscheme
      cmschuetz12.wal
      # rust-analyzer
      matklad.rust-analyzer
      WakaTime.vscode-wakatime
    ]) ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [{
      name = "remote-ssh-edit";
      publisher = "ms-vscode-remote";
      version = "0.47.2";
      sha256 = "1hp6gjh4xp2m1xlm1jsdzxw9d8frkiidhph6nvl24d0h8z34w49g";
    }
    # {
    #   name = "rewrap";
    #   publisher = "stkb";
    #   version = "1.0.1";
    # }
    # {
    #   name = "remote-containers";
    #   publisher = "ms-vscode-remote";
    #   version = "0.117.1";
    # }
      ];
  };
}
