{ config, pkgs, lib, ... }:

{
  # Ensure nix profile is sourced.
  programs.zsh.envExtra = ''
    source $HOME/.nix-profile/etc/profile.d/nix.sh
  '';

  programs.bash.bashrcExtra = ''
    source $HOME/.nix-profile/etc/profile.d/nix.sh
  '';
}

