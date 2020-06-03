{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.03";

  home.packages = with pkgs;
    let
      unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
    in [
      # (pkgs.vscode-with-extensions.override {
      #   vscodeExtensions = (with pkgs.vscode-extensions; [
      #       # nix syntax highlighting
      #       bbenoist.Nix
      #       ms-vscode-remote.remote-ssh
      #       ms-azuretools.vscode-docker
      #       ms-kubernetes-tools.vscode-kubernetes-tools
      #       # cmschuetz12.wal
      #       # rust-analyzer
      #       matklad.rust-analyzer
      #       WakaTime.vscode-wakatime
      #     ]) ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [{
      #       name = "remote-ssh-edit";
      #       publisher = "ms-vscode-remote";
      #       version = "0.47.2";
      #       sha256 = "1hp6gjh4xp2m1xlm1jsdzxw9d8frkiidhph6nvl24d0h8z34w49g";
      #     }

      #     # wal colorscheme
      #     {
      #       name = "wal-theme";
      #       publisher = "dlasagno";
      #       version = "1.0.4";
      #       sha256 = "1kn38anhhac3l1yanmhjqwv8ga8iaijyy7f56c8ifyzgqqz5bbxf";
      #     }
      #     # {
      #     #   name = "rewrap";
      #     #   publisher = "stkb";
      #     #   version = "1.0.1";
      #     # }
      #     # {
      #     #   name = "remote-containers";
      #     #   publisher = "ms-vscode-remote";
      #     #   version = "0.117.1";
      #     # }
      #     ];
      # })

      # toolchains
      vscode
      rustup
      clang
      llvmPackages.bintools
      ark
      # chat apps
      slack
      discord
      signal-desktop

      # stuff
      steam
      neofetch
      wpgtk
      pywal
      lm_sensors
      # tar

      # fonts
      iosevka
      unstable.cozette

      # nix stuff
      nix-prefetch-git
      nixfmt
    ];

  # programs.vscode = {
  #   enable = true;
  #   extensions = (with pkgs.vscode-extensions; [
  #     # nix syntax highlighting
  #     bbenoist.Nix
  #     ms-vscode-remote.remote-ssh
  #     ms-azuretools.vscode-docker
  #     ms-kubernetes-tools.vscode-kubernetes-tools
  #     # wal colorscheme
  #     cmschuetz12.wal
  #     # rust-analyzer
  #     matklad.rust-analyzer
  #     WakaTime.vscode-wakatime
  #   ]) ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [{
  #     name = "remote-ssh-edit";
  #     publisher = "ms-vscode-remote";
  #     version = "0.47.2";
  #     sha256 = "1hp6gjh4xp2m1xlm1jsdzxw9d8frkiidhph6nvl24d0h8z34w49g";
  #   }
  #   # {
  #   #   name = "rewrap";
  #   #   publisher = "stkb";
  #   #   version = "1.0.1";
  #   # }
  #   # {
  #   #   name = "remote-containers";
  #   #   publisher = "ms-vscode-remote";
  #   #   version = "0.117.1";
  #   # }
  #     ];
  #   # userSettings = {
  #   #   "editor.fontFamily" = "Iosevka";
  #   #   "editor.fontLigatures" = "'calt', 'dlig', 'ss08'";
  #   #   "editor.renderWhitespace" = "boundary";
  #   #   "workbench.colorTheme" = "Wal";
  #   #   "git.autofetch" = true;
  #   #   "files.associations" = {
  #   #     "zshrc" = "shellscript";
  #   #   };
  #   #   "rewrap.autoWrap.enabled" = true;
  #   #   "rewrap.reformat" = true;
  #   #   "editor.formatOnSave" = true;
  #   #   "[markdown]" =  {
  #   #     "files.trimTrailingWhitespace" = false;
  #   #     "editor.formatOnSave" = false;
  #   #     "editor.trimAutoWhitespace" = false;
  #   #     "rewrap.reformat" = false;
  #   #   };
  #   #   "wal.autoReload" = true;
  #   #   # "window.titleBarStyle" = "custom";
  #   # };
  # };

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
      userName = "Eliza Weisman";
      userEmail = "eliza@buoyant.io";
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
          size = 11;
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
}
