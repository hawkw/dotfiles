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
    valgrind
  ];

  # Nice terminal UI for gdb
  programs.gdb.dashboard = {
    enable = true;
    enablePygments = true;

    extraConfig = ''
      dashboard -layout assembly breakpoints expressions history memory registers source stack threads variables
      dashboard registers -style column-major True
      dashboard registers -style list 'rax rbx rcx rdx rsi rdi rbp rsp r8 r9 r10 r11 r12 r13 r14 r15 rip eflags cs ss ds es fs gs fs_base gs_base k_gs_base cr0 cr2 cr3 cr4 cr8 efe msxr'
    '';
  };
}
