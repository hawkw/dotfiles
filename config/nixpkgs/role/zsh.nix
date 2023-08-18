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
      syntaxHighlighting.enable = true;
      enableCompletion = true;
      enableVteIntegration = true;
      autocd = true;
      history = {
        ignoreDups = true;
        share = true;
      };

      initExtra = ''
        # xterm title setting stuff
        autoload -Uz add-zsh-hook

        function xterm_title_precmd () {
          print -Pn -- '\e]2;%n@%m %~\a'
          [[ "$TERM" == 'screen'* ]] && print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-}\e\\'
        }

        function xterm_title_preexec () {
          print -Pn -- '\e]2;%n@%m %~ %# ' && print -n -- "''${(q)1}\a"
          [[ "$TERM" == 'screen'* ]] && { print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-} %# ' && print -n -- "''${(q)1}\e\\"; }
        }

        if [[ "$TERM" == (Eterm*|alacritty*|aterm*|gnome*|konsole*|kterm*|putty*|rxvt*|screen*|tmux*|xterm*) ]]; then
          add-zsh-hook -Uz precmd xterm_title_precmd
          add-zsh-hook -Uz preexec xterm_title_preexec
        fi

        # Import colorscheme from 'wal' asynchronously
        if [[ "''${TERM}" = "alacritty" ]]; then
          (cat "''${HOME}/.cache/wal/sequences" &)
        fi
      '';

      envExtra = ''
        # Ensure cargo binaries are on the PATH
        export PATH="$PATH:$HOME/.cargo/bin"
        export PATH="$PATH:$HOME/.linkerd2/bin"
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
