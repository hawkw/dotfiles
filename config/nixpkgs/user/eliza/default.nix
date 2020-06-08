{ config, pkgs, lib, ... }:

let
  userData = {
    name = "Eliza Weisman";
    email = "eliza@buoyant.io";
  };
in {
  imports = [ ./fonts.nix ];

  home.sessionVariables = {
    EDITOR = "code --wait";
    BROWSER = "firefox";
    TERMINAL = "alacritty";
  };

  home.packages = with pkgs;
    let
      unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
    in [
      # toolchains
      vscode
      rustup
      clang
      llvmPackages.bintools

      # rusty unix utils
      exa
      # bat # installed via `programs.bat` 
      tokei
      xsv
      ripgrep
      fd
      bandwhich
      ytop

      # images, etc
      ark
      darktable

      # chat apps
      slack
      discord
      signal-desktop

      # stuff
      steam
      neofetch
      wpgtk
      pywal

      # "crypto"
      keybase
      keybase-gui
      kbfs
      gnupg

      # nix stuff
      nix-prefetch-git
      nixfmt
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
        package.symbol = "";
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
    };

    htop.enable = true;

    alacritty = {
      enable = true;
      settings = {
        # Configuration for Alacritty, the GPU enhanced terminal emulator
        # Live config reload (changes require restart)
        live_config_reload = true;
        shell.program = "zsh";
        window = {
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
          size = 8;
          # The normal (roman) font face to use.
          normal = {
            family = "Cozette";
            style = "Regular";
          };

          bold = {
            family = "Cozette";
            style = "Bold";
          };

          italic = {
            family = "Cozette";
            style = "Italic";
          };
        };
      };
    };

    keychain = {
      enable = true;
      enableZshIntegration = true;
      enableXsessionIntegration = true;
      keys = [ "id_ed25519" ];
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
}
