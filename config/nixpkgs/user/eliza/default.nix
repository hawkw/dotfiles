{ config, pkgs, lib, ... }:

let
  userData = {
    name = "Eliza Weisman";
    email = "eliza@buoyant.io";
  };
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in {
  imports = [
    ./fonts.nix
    ../../role/zsh.nix
    ../../role/vscode.nix
    ../../role/rusty.nix
    ../../role/git.nix
    ../../role/devbox.nix
    ../../pkgs/atuin.nix
  ];

  home.sessionVariables = {
    EDITOR = "code --wait";
    BROWSER = "firefox";
    TERMINAL = "alacritty";
  };

  # programs.steam.enable = true;
  home.packages = with pkgs;
    let
      unfreePkgs = [
        slack
        unstable.discord
        signal-desktop
        zoom-us
        unstable.steam
        keybase
        keybase-gui
        unstable._1password
        unstable._1password-gui
        spotify
      ];
    in ([

      ### networking tools ##
      nmap-graphical
      mtr-gui
      slurm
      bandwhich
      nghttp2
      # assorted wiresharks
      wireshark
      termshark
      tcpdump

      ### images, media, etc ###
      ark
      darktable
      unstable.inkscape
      obs-studio
      llpp # fast & lightweight PDF pager
      krita # like the GNU Image Manipulation Photoshop, but more good
      gimp

      ### stuff ###
      neofetch
      wpgtk
      pywal
      dtrx # Do The Right eXtraction --- extract any kind of archive file

      ### "crypto" ###
      kbfs
      gnupg

      ### nix stuff ###
      nix-prefetch-git
      nixfmt
      nix-index

      wally-cli
      chromium
      asciinema
    ] ++ unfreePkgs);

  #############################################################################
  ## Programs                                                                 #
  #############################################################################
  # my custom config modules
  programs.eliza = {
    # use a collection of Rust versions of common unix utilities.
    rustyUtils = {
      enable = true;
      enableAliases = true;
    };

    # custom git configs
    git = {
      enable = true;
      user = {
        name = userData.name;
        email = userData.email;
        privateConfig = ./git.private.nix;
      };
    };
  };

  programs = {
    nushell = {
      enable = true;
      settings = {
        pivot_mode = "always";
        nonzero_exit_errors = "true";
      };
    };

    atuin = {
      enable = true;
      config = {
        dialect = "us";
        auto_sync = true;
      };
    };

    starship = {
      enable = true;
      settings = {
        username.show_always = true;
        hostname.ssh_only = false;

        # Replace the "❯" symbol in the prompt with ":;"
        #
        # why use ":;" as the prompt character? it is a no-op in most (all?) unix shells, so copying and
        # pasting a command including the prompt character will still work
        character = {
          success_symbol = "[:;](bold green)";
          error_symbol = "[:](bold green)[;](bold red)";
        };

        hostname.format = "at [$hostname]($style) in ";
        username.format = "[$user]($style) ";
        nodejs.disabled = true;

        rust.symbol = "⚙️ ";
        # package.symbol = "";
        nix_shell = {
          symbol = "❄️ ";
          impure_msg = "[\\[impure\\]](bold red)";
          pure_msg = "[\\[pure\\]](bold green)";
          format = "in [$symbol$name]($style) $state ";
        };

        format = lib.concatStrings [
          # Start the first line with a shell comment so that the entire prompt
          # can be copied and pasted.
          "[:#](bold green) "
          "$username"
          "$hostname"
          "$shlvl"
          "$kubernetes"
          "$directory"
          "$git_branch"
          "$git_commit"
          "$git_state"
          "$git_status"
          "$hg_branch"
          "$docker_context"
          "$package"
          "$cmake"
          # "$dart"
          "$dotnet"
          "$elixir"
          "$elm"
          "$erlang"
          "$golang"
          "$helm"
          "$java"
          "$julia"
          # "$kotlin"
          # "$nim"
          "$nodejs"
          "$ocaml"
          "$perl"
          "$php"
          # "$purescript"
          "$python"
          "$ruby"
          "$rust"
          "$swift"
          # "$terraform"
          "$vagrant"
          # "$zig"
          "$nix_shell"
          "$conda"
          "$memory_usage"
          "$aws"
          "$gcloud"
          # "$openstack"
          "$env_var"
          "$crystal"
          "$custom"
          "$cmd_duration"
          "$lua"
          "$jobs"
          "$battery"
          "$time"
          "$status"
          "$line_break"
          "$character"
        ];

      };
    };

    jq.enable = true;
    command-not-found.enable = true;
    direnv.enable = true;

    htop = {
      enable = true;
      settings = {
        highlight_base_name = true;
        highlight_threads = true;
        # showThreadNames = true;
        # on NixOS, pretty much every path starts with /nix/store/(LONG SHA).
        # Because of that, when the whole path is shown, you need a really
        # wide terminal window, or else the program names are not really
        # readable. So let's turn off paths.
        show_program_path = false;
        # This is rarely useful but it's cool to see, if you're me.
        hide_kernel_threads = false;

        # I have entirely too many cores for the default meter configuration to
        # be useable. :)
        left_meter_modes = [ "LeftCPUs2" "Blank" "Memory" "Swap" ];
        right_meter_modes =
          [ "RightCPUs2" "Blank" "Hostname" "Uptime" "Tasks" "LoadAverage" ];
      };
    };

    alacritty = {
      enable = true;
      settings = {
        # Configuration for Alacritty, the GPU enhanced terminal emulator
        # Live config reload (changes require restart)
        live_config_reload = true;
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
    # gpg-agent = { enable = true; };
    kbfs.enable = true;
    keybase.enable = true;
    gnome-keyring = {
      enable = true;
      components = [ "pkcs11" "secrets" "ssh" ];
    };
  };

  #############################################################################
  ## Programs                                                                 #
  #############################################################################
  programs = {
    # # Keychain
    # keychain = {
    #   enable = true;
    #   enableXsessionIntegration = true;
    #   keys = [ "id_ed25519" ];
    # };

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

    firefox = { enable = true; };
  };

}
