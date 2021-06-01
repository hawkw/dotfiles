{ config, pkgs, lib, ... }:

let
  enableService = config.services.openrgb.enable;
  enableDesktop = config.programs.openrgb.enable;
  unstable = import <nixos-unstable> { config = config.nixpkgs.config; };
in with lib; {
  options = {
    services.openrgb.enable = mkEnableOption "OpenRGB background service";
    programs.openrgb.enable = mkEnableOption "OpenRGB";
  };
  config = mkMerge [
    {
      environment.systemPackages = [ unstable.openrgb ];
    }

    # if the systemd service is enabled
    (mkIf enableService {
      systemd.services.openrgb = {
        wantedBy = [ "default.target" ];
        description = "OpenRGB RGB controller";
        serviceConfig = {
          Type = "simple";
          User = "nobody";
          ExecStart = "${unstable.openrgb} --server";
        };
      };
    })
    # if the desktop entry is enabled
    (mkIf enableDesktop {
      environment.systemPackages = let
        desktopItem = pkgs.makeDesktopItem {
          type = "Application";
          encoding = "UTF-8";
          desktopName = "OpenRGB";
          comment = "Control RGB lighting";
          icon = "OpenRGB";
          exec = "${unstable.openrgb} --startminimized";
          terminal = "false";
          categories = "Utility";
        };
      in [ desktopItem ];
    })
  ];
}
