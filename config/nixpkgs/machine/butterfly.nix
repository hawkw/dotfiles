{ config, pkgs, lib, ... }:

{
  # Ensure nix profile is sourced.
  programs.zsh.envExtra = ''
    source $HOME/.nix-profile/etc/profile.d/nix.sh
    export PATH="$HOME/.cargo/bin:$HOME/.linkerd2/bin:$PATH"
  '';

  programs.bash.bashrcExtra = ''
    source $HOME/.nix-profile/etc/profile.d/nix.sh
    export PATH="$HOME/.cargo/bin:$HOME/.linkerd2/bin:$PATH"
  '';

  services = {
    gpg-agent = {
      enable = true;
      # don't have `home-manager` set the pinentry program because it's not
      # installed using nix here...
      pinentryFlavor = null;
      extraConfig = "pinentry-program /usr/bin/pinentry-gtk-2";
    };
  };
}

