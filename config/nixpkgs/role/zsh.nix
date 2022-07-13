{ config, pkgs, ... }:

{

  programs = {
    # enable zsh integration options on other packages
    direnv.enableZshIntegration = true;
    keychain.enableZshIntegration = true;
    starship.enableZshIntegration = true;

    alacritty.settings.shell.program = "zsh";

    # zsh config
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;
      enableCompletion = true;
      enableVteIntegration = true;
      autocd = true;
      history = {
        ignoreDups = true;
        share = true;
      };

      # Import wal color scheme
      initExtra = ''
        # Import colorscheme from 'wal' asynchronously
        if [[ "''${TERM}" = "alacritty" ]]; then
          (cat "''${HOME}/.cache/wal/sequences" &)
        fi
      '';
      # Ensure cargo binaries are on the PATH
      envExtra = ''
        export PATH="$PATH:$HOME/.cargo/bin"
      '';

      # aliases
      shellAliases = {
        # im a dumbass
        cagro = "cargo";
        carg = "cargo";
        gti = "git";
      };
    };
  };

}
