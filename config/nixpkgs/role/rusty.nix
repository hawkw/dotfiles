{ config, pkgs, lib, ... }:

let unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in {
  home.packages = [
    ### rusty unix utils ###
    unstable.tokei
    unstable.xsv
    unstable.ripgrep
    unstable.fd
    # unstable.ytop
    unstable.bottom
  ];

  programs = {
    bat = { enable = true; };
    broot.enable = true;
    exa = {
      enable = true;
      enableAliases = true;
    };
    zsh.shellAliases = {
      # hahaha get rekt tree
      tree = "${pkgs.exa}/bin/exa --tree";
      grep = "${pkgs.ripgrep}/bin/rg";
    };
  };
}
