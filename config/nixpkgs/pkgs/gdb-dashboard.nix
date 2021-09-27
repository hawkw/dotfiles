{ config, lib, pkgs, ... }:

with lib;
let
  gdbinitPkg = { stdenv, lib, pkgs }:
    stdenv.mkDerivation rec {
      pname = "gdb-dashboard";
      version = "latest";

      src = pkgs.fetchFromGitHub {
        owner = "cyrus-and";
        repo = "gdb-dashboard";
        rev = "101cf69cc95f90956b6d9612a3468dac6422c87c";
        sha256 = "145c9y7wj3mi34k3y2isvs3v4k7mmiyn6lc477m8hhc9js1q2ia4";
      };

      phases = "installPhase";

      installPhase = ''
        set +x
        mkdir -p $out
        cp -v $src/.gdbinit $out/.gdbinit
      '';

      meta = with lib; {
        description = "Modular visual interface for GDB in Python";
        homepage = "https://github.com/cyrus-and/gdb-dashboard";
        license = licenses.mit;
      };
    };
  cfg = config.programs.gdb.dashboard;
in {
  options.programs.gdb.dashboard = {
    enable = mkEnableOption "dashboard";
    enablePygments = mkEnableOption "pygments" // {
      description = "whether to enable Pygments syntax highlighting";
    };
    gdbPackage = mkOption {
      type = types.package;
      default = pkgs.gdb;
      defaultText = literalExample "pkgs.gdb";
      description = "The package to use for gdb.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = mkMerge [
      (mkIf cfg.enablePygments [ pkgs.python39Packages.pygments ])
      [ cfg.gdbPackage ]
    ];
    home.file.".gdbinit".text = let pkg = pkgs.callPackage gdbinitPkg { };
    in builtins.readFile "${pkg}/.gdbinit";
  };
}
