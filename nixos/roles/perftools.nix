# Configuration for Linux performance profiling tools (perf, ebpf tracing,
# flamegraphs).
{ config, lib, pkgs, ... }:

with lib;
let linuxpkgs = config.boot.kernelPackages;
in {
  options.programs.perftools.enable = mkEnableOption "perftools";

  config = mkIf config.programs.perftools.enable {
    environment.systemPackages = with pkgs; [
      # use the correct version of `perf` for the configured `linuxPackages`
      linuxpkgs.perf
      # also include userspace perf-tools and flamegraph scripts
      perf-tools
      flamegraph
    ];
    # this does the same thing as above (using the correct `linuxPackages`) but
    # for `bcc`...sad there's no version of this for perf out of the box.
    programs.bcc.enable = true;
  };
}
