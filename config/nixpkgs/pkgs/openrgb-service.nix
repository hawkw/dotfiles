{ config, pkgs, lib, ... }:

let cfg = config.services.openRgb;
in with lib; {
  options = { enable = lib.mkEnableOption "OpenRGB"; };
  config = lib.mkIf cfg.enable {

  };
}
