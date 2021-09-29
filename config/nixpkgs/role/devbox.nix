{ config, pkgs, lib, ... }:

{
  imports = [ ../pkgs/gdb-dashboard.nix ];
  home.packages = let unstable = import <nixos-unstable> { config = config; };
  in with pkgs; [
    # ## toolchains ###
    rustup
    clang

    ### devtools ###
    # llvmPackages.bintools
    # use lldb from unstable, since it's on a newer version
    unstable.lldb
    # the good `time`, not the shell builtin
    time
    docker-compose
    psmisc
  ];

  # Nice terminal UI for gdb
  programs.gdb.dashboard = {
    enable = true;
    enablePygments = true;
  };
}
