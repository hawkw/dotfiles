{ config, pkgs, lib, ... }:

let
  cfg = config.programs.eliza.rustyUtils;
  zshEnabled = config.programs.zsh.enable;
  bashEnabled = config.programs.bash.enable;
  fishEnabled = config.programs.fish.enable;
  unstable = import <nixos-unstable> { config = config; };
in with lib; {
  options = {
    programs.eliza.rustyUtils = {
      enable = mkEnableOption "rusty unix utils";
      enableAliases = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      home.packages = with unstable; [
        ### rusty unix utils ###
        tokei
        xsv
        ripgrep
        fd
        # unstable.ytop
        bottom
        glances
      ];

      programs = {
        bat = { enable = true; };
        broot = {
          enable = true;
          verbs = [{
            name = "view";
            invocation = "view";
            key = "enter";
            execution = "bat {file}";
            leave_broot = false;
            apply_to = "file";
          }];
        };

        exa = { enable = true; };
        zoxide = { enable = true; };
      };
    }

    # If aliases are enabled, alias common unix utils with their rustier replacements.
    (mkIf cfg.enableAliases (mkMerge [
      # enable exa aliases
      { programs.exa.enableAliases = true; }

      (mkIf zshEnabled {
        programs.zsh.shellAliases = {
          # hahaha get rekt tree
          tree = "${pkgs.exa}/bin/exa --tree";
          grep = "${pkgs.ripgrep}/bin/rg";
        };
      })
      (mkIf bashEnabled {
        programs.bash.shellAliases = {
          # hahaha get rekt tree
          tree = "${pkgs.exa}/bin/exa --tree";
          grep = "${pkgs.ripgrep}/bin/rg";
        };
      })
      (mkIf fishEnabled {
        programs.bash.shellAliases = {
          # hahaha get rekt tree
          tree = "${pkgs.exa}/bin/exa --tree";
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
