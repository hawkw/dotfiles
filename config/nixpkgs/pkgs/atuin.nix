{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.programs.atuin;
  tomlFormat = pkgs.formats.toml { };
in {
  options.programs.atuin = {
    enable = mkEnableOption "atuin";

    package = mkOption {
      type = types.package;
      default = pkgs.atuin;
      defaultText = literalExample "pkgs.atuin";
      description = "The package to use for atuin.";
    };

    enableBashIntegration = mkEnableOption "Bash integration" // {
      default = true;
    };

    enableZshIntegration = mkEnableOption "Zsh integration" // {
      default = true;
    };

    settings = mkOption {
      type = with types;
        let
          prim = oneOf [ bool int str ];
          primOrPrimAttrs = either prim (attrsOf prim);
          entry = either prim (listOf primOrPrimAttrs);
          entryOrAttrsOf = t: either entry (attrsOf t);
          entries = entryOrAttrsOf (entryOrAttrsOf entry);
        in attrsOf entries // { description = "Atuin configuration"; };
      default = { };
      example = literalExample ''
        {
          # where to store your database, default is your system data directory
          # mac: ~/Library/Application Support/com.elliehuxtable.atuin/history.db
          # linux: ~/.local/share/atuin/history.db
          db_path = "~/.history.db";

          ## where to store your encryption key, default is your system data directory
          key_path = "~/.key";

          ## where to store your auth session token, default is your system data directory
          session_path = "~/.key";

          ## date format used, either "us" or "uk"
          dialect = "uk";

          ## enable or disable automatic sync
          auto_sync = true;

          ## how often to sync history. note that this is only triggered when a command
          ## is ran, so sync intervals may well be longer
          ## set it to 0 to sync after every command
          sync_frequency = "5m";

          ## address of the sync server
          sync_address = "https://api.atuin.sh";

          ## which search mode to use
          ## possible values: prefix, fulltext, fuzzy
          search_mode = "prefix";
        }
      '';
      description = ''
        Configuration written to
        <filename>~/.config/atuin/config.toml</filename>.
        </para><para>
        See <link xlink:href="https://github.com/ellie/atuin/blob/main/docs/config.md" /> for the full list
        of options.
      '';
    };
  };

  config = mkIf cfg.enable (mkMerge [
    # Always add the configured `atuin` package.
    {
      home.packages = [ cfg.package ];
    }

    # If there are user-provided settings, generate the config file.
    (mkIf (cfg.settings != { }) {
      xdg.configFile."atuin/config.toml" = {
        source = tomlFormat.generate "atuin-config" cfg.settings;
      };
    })

    (mkIf cfg.enableBashIntegration (let
      # This adds hooks which are required for `atuin`'s bash integration.
      # See https://github.com/ellie/atuin#bash
      bashPreexecPkg = { stdenv, lib, pkgs }:
        stdenv.mkDerivation rec {
          pname = "bash-preexec";
          version = "0.4.1";

          src = pkgs.fetchFromGitHub {
            owner = "rcaloras";
            repo = "bash-preexec";
            rev = version;
            sha256 = "062iigps285628p710i7vh7kmgra5gahq9qiwj7rxir167lg0ggw";
          };
          phases = "installPhase";

          installPhase = ''
            set +x
            mkdir -p $out
            cp -v $src/bash-preexec.sh $out/bash-preexec.sh
            chmod -x $out/bash-preexec.sh
          '';

          meta = with lib; {
            description =
              "preexec and precmd functions for Bash just like Zsh.";
            license = licenses.mit;
            homepage = "https://github.com/rcaloras/bash-preexec";
            # platforms = platforms.linux;
            # maintainers = with maintainers; [ remunds ];
          };
        };
      bashPreexec = (pkgs.callPackage bashPreexecPkg { });
    in {
      home.packages = [ bashPreexec ];
      programs.bash.initExtra = ''
        source ${bashPreexec}/bash-preexec.sh
        eval "$(${cfg.package}/bin/atuin init bash)
      '';
    }))

    (mkIf cfg.enableZshIntegration {
      programs.zsh.initExtra = ''
        eval "$(${cfg.package}/bin/atuin init zsh)"
      '';
    })
  ]);
}
