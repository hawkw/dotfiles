{
  allowUnfree = true;
  #   packageOverrides = pkgs:
  #     with pkgs; {
  #       vscode = pkgs.vscode.override { isInsiders = true; };
  #       myPackages = pkgs.buildEnv {
  #         name = "my-packages";
  #         paths = [ gdb vscode ];
  #       };
  #     };
}
