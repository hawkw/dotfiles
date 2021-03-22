{ config, pkgs, ... }:

{
  programs = {
    # enable zsh integration options on other packages
    direnv.enableZshIntegration = true;
    keychain.enableZshIntegration = true;
    starship.enableZshIntegration = true;
    broot.enableZshIntegration = true;
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    alacritty.settings.shell.program = "zsh";

    # zsh config
    zsh = {
      enable = true;
      enableAutosuggestions = true;
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
        (cat "''${HOME}/.cache/wal/sequences" &)
      '';
      # Ensure cargo binaries are on the PATH
      envExtra = ''
        export PATH="$PATH:$HOME/.cargo/bin"
      '';

      # Configure ZSH plugins via zplug
      zplug = {
        enable = true;
        plugins = [{ # ZSH syntax highlighting.
          name = "zsh-users/zsh-syntax-highlighting";
          # this must be loaded after compinit, so use defer.
          tags = [ "defer:2" ];
        }];
      };
    };
  };

}
