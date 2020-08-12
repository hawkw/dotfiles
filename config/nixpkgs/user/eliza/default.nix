{ config, pkgs, lib, ... }:

let
  userData = {
    name = "Eliza Weisman";
    email = "eliza@buoyant.io";
  };
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in {
  # imports = [ ./fonts.nix ];

  home.sessionVariables = {
    EDITOR = "code --wait";
    BROWSER = "firefox";
    TERMINAL = "alacritty";
  };

  fonts.fontconfig.enable = true;
  home.packages = with pkgs;
    let
      discordRev = import (pkgs.fetchFromGitHub {
        owner = "NixOS";
        repo = "nixpkgs";
        rev = "9fbbe30a44e31db059cd95de6046c01879f8c3dd";
        sha256 = "0r6fqw1fs5flmn8sg1k6jrgh8s5zf3wkkvnpzr52chjq142dybfq";
      }) { config = { allowUnfree = true; }; };
    in [
      # toolchains
      vscode
      rustup
      clang
      llvmPackages.bintools
      nodejs-12_x # required for vscode remote ssh
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

      # chat apps
      slack
      discordRev.discord
      signal-desktop

      # stuff
      steam
      neofetch
      wpgtk
      pywal
      obs-studio

      # "crypto"
      keybase
      keybase-gui
      kbfs
      gnupg

      # nix stuff
      nix-prefetch-git
      nixfmt

      wally-cli

      # fonts
      iosevka
      unstable.cozette
      #   cherry
      roboto
    ];

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
      autocd = true;
      history = {
        ignoreDups = true;
        share = true;
      };
      initExtra = ''
        # Import colorscheme from 'wal' asynchronously
        (cat "''${HOME}/.cache/wal/sequences" &)
      '';
      plugins = [
        {
          # will source zsh-syntax-highlighting.plugin.zsh
          name = "zsh-syntax-highlighting";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-syntax-highlighting";
            rev = "0.7.1";
            sha256 = "03r6hpb5fy4yaakqm3lbf4xcvd408r44jgpv4lnzl9asp4sb9qc0";
          };
        }
        {
          # will source zsh-z.plugin.zsh
          name = "zsh-z";
          src = pkgs.fetchFromGitHub {
            owner = "agkozak";
            repo = "zsh-z";
            rev = "e138de57cd59ed09c3d55ff544ff8f79d2dc4ac1";
            sha256 = "02b3r4bv8mz16xqngpi2353gv8fb478fwy10786i9j3ymp4hql5j";
          };
        }
      ];
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

        # Font configuration (changes require restart)
        font = {
          # Point size of the font
          size = 9;
          # The normal (roman) font face to use.
          normal = {
            family = "Iosevka";
            style = "Regular";
          };

          bold = {
            family = "Iosevka";
            style = "Bold";
          };

          italic = {
            family = "Iosevka";
            style = "Italic";
          };
        };
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
    keychain = {
      enable = true;
      enableZshIntegration = true;
      enableXsessionIntegration = true;
      keys = [ "id_ed25519" ];
    };
  };
}
