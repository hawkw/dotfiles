{ config, pkgs, lib, ... }:

let
  userData = {
    name = "Eliza Weisman";
    email = "eliza@buoyant.io";
  };
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in {
  imports = [ ./fonts.nix ];

  home.sessionVariables = {
    EDITOR = "code --wait";
    BROWSER = "firefox";
    TERMINAL = "alacritty";
  };

  home.packages = with pkgs;
    let
      unfreePkgs = [
        slack
        unstable.discord
        signal-desktop
        zoom-us
        steam
        keybase
        keybase-gui
        vscode
        nodejs-12_x # required for vscode remote ssh
        unstable._1password
        spotify
        # unstable._1password-gui
      ];
    in ([
      # toolchains
      rustup
      clang
      llvmPackages.bintools
      # rusty unix utils
      unstable.exa
      unstable.tokei
      unstable.xsv
      unstable.ripgrep
      unstable.fd
      unstable.ytop
      # unstable.broot
      # bat # installed via `programs.bat` 

      # github cli
      gitAndTools.gh

      psmisc

      # networking tools
      nmap-graphical
      mtr-gui
      slurm
      bandwhich
      nghttp2
      # assorted wiresharks
      wireshark
      termshark

      # kubernetes
      kubectl
      unstable.kube3d
      kubectx
      k9s
      stern
      helm

      # images, etc
      ark
      darktable
      unstable.inkscape

      # stuff
      neofetch
      wpgtk
      pywal
      obs-studio

      # "crypto"
      kbfs
      gnupg

      # nix stuff
      nix-prefetch-git
      nixfmt

      wally-cli
    ] ++ unfreePkgs);

  #############################################################################
  ## Programs                                                                 #
  #############################################################################
  programs = {
    starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        username.show_always = true;
        hostname.ssh_only = false;

        # Replace the "❯" symbol in the prompt with ":;"
        #
        # why use ":;" as the prompt character? it is a no-op in most (all?) unix shells, so copying and
        # pasting a command including the prompt character will still work
        character.symbol = ":;";
        rust.symbol = "⚙️ ";
        # package.symbol = "";
        # nix_shell.use_name = true;
        kubernetes = { disabled = false; };
        prompt_order = [
          "username"
          "hostname"
          "directory"
          "kubernetes"
          "git_branch"
          "git_commit"
          "git_state"
          "git_status"
          "hg_branch"
          "docker_context"
          "package"
          "dotnet"
          "elixir"
          "elm"
          "erlang"
          "golang"
          "java"
          "julia"
          "nim"
          "nodejs"
          "ocaml"
          "php"
          "purescript"
          "python"
          "ruby"
          "rust"
          "terraform"
          "zig"
          "nix_shell"
          "conda"
          "memory_usage"
          "aws"
          "env_var"
          "crystal"
          "cmd_duration"
          "custom"
          "line_break"
          "jobs"
          "battery"
          "time"
          "character"
        ];

      };
    };

    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      #      enableVteIntegration = true;
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
        plugins = [
          { # ZSH syntax highlighting.
            name = "zsh-users/zsh-syntax-highlighting";
            # this must be loaded after compinit, so use defer.
            tags = [ "defer:2" ];
          }
          {
            name = "agkozak/zsh-z";
            tags = [ "from:github" ];
          }
        ];
      };
    };

    jq.enable = true;
    bat.enable = true;
    command-not-found.enable = true;

    broot = {
      enable = true;
      enableZshIntegration = true;
      # package = unstable.broot;
      skin = {
        default = "gray(23) none";
        tree = "ansi(94) None / gray(3) None";
        file = "gray(18) None / gray(15) None";
      };
    };

    direnv = {
      enable = true;
      enableZshIntegration = true;
    };

    git = {
      enable = true;
      userName = userData.name;
      userEmail = userData.email;

      # aliases
      aliases = {
        rb = "rebase";
        rbct = "rebase --continue";
        # sign the last commit
        sign = "commit --amend --reuse-message=HEAD -sS";
        uncommit = "reset --hard HEAD";
        ls = ''
          log --pretty=format:"%C(yellow)%h%Cred%d\ %Creset%s%Cblue\ [%cn]" --decorate'';
        ll = ''
          log --pretty=format:"%C(yellow)%h%Cred%d\ %Creset%s%Cblue\ [%cn]" --decorate --numstat'';
        lt = "log --graph --oneline --decorate --all";
        st = "status --short --branch";
        stu = "status -uno";
        co = "checkout";
        ci = "commit";
        pr =
          "!pr() { git fetch origin pull/$1/head:pr-$1; git checkout pr-$1; }; pr";
        lol = "log --graph --decorate --pretty=oneline --abbrev-commit";
        lola = "log --graph --decorate --pretty=oneline --abbrev-commit --all";
        please = "push --force-with-lease";
        commend = "commit --amend --no-edit";
        squash = "merge --squash";
        # Get the current branch name (not so useful in itself, but used in
        # other aliases)
        branch-name = "!git rev-parse --abbrev-ref HEAD";
        # Push the current branch to the remote "origin", and set it to track
        # the upstream branch
        publish = "!git push -u origin $(git branch-name)";
        # Delete the remote version of the current branch
        unpublish = "!git push origin :$(git branch-name)";
      };

      # extra git config
      extraConfig = {
        # use the default pull configuration, but stop whinging about it.
        pull.rebase = false;
      };

      # If there is a file called `.git.private.nix` that defines an attribute
      # "key", sign commits with that key.
      signing = let path = ./git.private.nix;
      in if builtins.pathExists path then {
        key = with import path; key;
        signByDefault = true;
      } else
        { };
    };

    htop = {
      enable = true;
      highlightBaseName = true;
      highlightThreads = true;
      # showThreadNames = true;
      # on NixOS, pretty much every path starts with /nix/store/(LONG SHA).
      # Because of that, when the whole path is shown, you need a really 
      # wide terminal window, or else the program names are not really 
      # readable. So let's turn off paths.
      showProgramPath = false;
      # This is rarely useful but it's cool to see, if you're me.
      hideKernelThreads = false;

      # I have entirely too many cores for the default meter configuration to
      # be useable. :)
      meters = {
        left = [ "LeftCPUs2" "Blank" "Memory" "Swap" ];
        right =
          [ "RightCPUs2" "Blank" "Hostname" "Uptime" "Tasks" "LoadAverage" ];
      };
    };

    alacritty = {
      enable = true;
      settings = {
        # Configuration for Alacritty, the GPU enhanced terminal emulator
        # Live config reload (changes require restart)
        live_config_reload = true;
        shell.program = "zsh";
        window = {
          dynamic_title = true;
          # Window dimensions in character columns and lines
          # (changes require restart)
          dimensions = {
            columns = 99;
            lines = 50;
          };

          # Adds this many blank pixels of padding around the window
          # Units are physical pixels; this is not DPI aware.
          # (change requires restart)
          padding = {
            x = 30;
            y = 30;
          };

          # Window decorations
          # Setting this to false will result in window without borders and title bar.
          # decorations: false
        };

        # When true, bold text is drawn using the bright variant of colors.
        draw_bold_text_with_bright_colors = true;

        # Fonts are configured in fonts.nix
      };
    };
  };

  #############################################################################
  ## Services                                                                 #
  #############################################################################
  services = {
    gpg-agent = { enable = true; };
    kbfs.enable = true;
    keybase.enable = true;
    gnome-keyring.enable = true;
  };

  #############################################################################
  ## Programs                                                                 #
  #############################################################################
  programs = {
    # Keychain
    keychain = {
      enable = true;
      enableZshIntegration = true;
      enableXsessionIntegration = true;
      keys = [ "id_ed25519" ];
    };

    tmux = {
      enable = true;
      plugins = with pkgs.tmuxPlugins; [
        sensible
        cpu
        continuum
        prefix-highlight
        yank
      ];
      extraConfig = ''
        # Status bar settings adapted from powerline
        set -g status on
        set -g status-interval 10
        set -g status-fg white
        set -g status-bg black
        set -g status-left-length 20
        set -g status-left '#{?client_prefix,#[fg=default]#[bg=red]#[bold],#[fg=red]#[bg=black]#[bold]} #S #{?client_prefix,#[fg=red]#[bg=magenta]#[nobold],#[fg=black]#[bg=magenta]#[nobold]}'
        set -g status-right '#(eval cut -c3- ~/.tmux.conf | sh -s status_right) #h '
        set -g status-right-length 150
        set -g window-status-format "#[fg=black,bg=red]#I #[fg=colour240] #[default]#W "
        set -g window-status-current-format "#[fg=b,bg=blue]#[fg=black,bg=blue] #I  #[fg=black]#W #[fg=blue,bg=black,nobold]"
        set -g window-status-last-style fg=white

        # ENDOFCONF
        # status_right() {
        #   cols=$(tmux display -p '#{client_width}')
        #   if (( $cols >= 80 )); then
        #     hoststat=$(hash tmux-mem-cpu-load && tmux-mem-cpu-load -i 10 || uptime | cut -d: -f5)
        #     echo "#[fg=colour233,bg=default,nobold,noitalics,nounderscore]#[fg=colour247,bg=colour233,nobold,noitalics,nounderscore] ⇑ $hoststat #[fg=colour252,bg=colour233,nobold,noitalics,nounderscore]#[fg=colour16,bg=colour252,bold,noitalics,nounderscore]"
        #   else
        #     echo '#[fg=colour252,bg=colour233,nobold,noitalics,nounderscore]#[fg=colour16,bg=colour252,bold,noitalics,nounderscore]'
        #   fi
        # }
        # clone () {
        #   orig=''${1%-*}
        #   let i=$( tmux list-sessions -F '#S' | sed -nE "/^''${orig}-[0-9]+$/{s/[^0-9]//g;p}" | tail -n1 )+1
        #   copy="$orig-$i"
        #   TMUX= tmux new-session -d -t $orig -s $copy
        #   tmux switch-client -t $copy
        #   tmux set -q -t $copy destroy-unattached on
        # }
        # $@
        # # vim: ft=tmux
      '';
    };
  };

}
