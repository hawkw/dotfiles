{ config, pkgs, lib, ... }:

let cfg = config.programs.eliza.rustyUtils;
in with lib; {
  options = {
    programs.eliza.rustyUtils = {
      enable = mkEnableOption "rusty unix utils";
      enableAliases = mkOption {
        type = types.bool;
        default = false;
      };
      atuin = {
        enable = mkEnableOption "atuin: shell history with cloud sync";
      };
    };
  };

  config = let
    mcflyEnabled = config.programs.mcfly.enable;
    # which shells are enabled?
    zshEnabled = config.programs.zsh.enable;
    bashEnabled = config.programs.bash.enable;
    fishEnabled = config.programs.fish.enable;
  in mkIf cfg.enable (mkMerge [
    {
      home.packages = with pkgs; [
        tokei
        xsv
        ripgrep
        fd
        # ytop
        bottom
        glances
        # dust: like `du` but good
        du-dust
        # procs: list processes
        procs
      ];

      programs = {
        bat = { enable = true; };
        broot = {
          enable = true;
          settings.verbs = [{
            name = "view";
            invocation = "view";
            key = "enter";
            execution = "bat {file}";
            leave_broot = false;
            apply_to = "file";
          }];
        };

        # exa: a (non-backwards-compatible) ls-like tool
        eza = { enable = true; };
        zoxide = { enable = true; };
        # lsd: a backwards compatible `ls` replacement
        lsd = {
          enable = true;
          settings = {
            icons = {
              when = "auto";
              # use unicode icons rather than fontawesome or whatever (for compatibility).
              # theme = "unicode";
              separator = "  ";
            };
          };
        };
      };
    }

    # mcfly: shell history (ctrl-r) replacement
    (mkIf mcflyEnabled (mkMerge [
      { programs.mcfly = { enableFuzzySearch = true; }; }

      (mkIf zshEnabled { programs.mcfly.enableZshIntegration = true; })
      (mkIf bashEnabled { programs.mcfly.enableBashIntegration = true; })
      (mkIf fishEnabled { programs.mcfly.enableFishIntegration = true; })
    ]))

    # If aliases are enabled, alias common unix utils with their rustier replacements.
    (mkIf cfg.enableAliases (mkMerge [
      { programs.lsd.enableAliases = true; }

      (mkIf zshEnabled {
        programs.zsh.shellAliases = {
          # hahaha get rekt tree
          tree = "${pkgs.lsd}/bin/lsd --tree";
          grep = "${pkgs.ripgrep}/bin/rg";
        };
      })
      (mkIf bashEnabled {
        programs.bash.shellAliases = {
          # hahaha get rekt tree
          tree = "${pkgs.lsd}/bin/lsd --tree";
          grep = "${pkgs.ripgrep}/bin/rg";
        };
      })
      (mkIf fishEnabled {
        programs.bash.shellAliases = {
          # hahaha get rekt tree
          tree = "${pkgs.lsd}/bin/lsd --tree";
          grep = "${pkgs.ripgrep}/bin/rg";
        };
      })
    ]))

    # if zsh is enabled, enable shell integration
    (mkIf zshEnabled {
      programs.zoxide.enableZshIntegration = true;
      programs.broot.enableZshIntegration = true;
    })

    # if bash is enabled, enable shell integration
    (mkIf bashEnabled {
      programs.zoxide.enableBashIntegration = true;
      programs.broot.enableBashIntegration = true;
    })

    # if fish is enabled, enable shell integration
    (mkIf fishEnabled {
      programs.zoxide.enableFishIntegration = true;
      programs.broot.enableFishIntegration = true;
    })
  ]);
}
