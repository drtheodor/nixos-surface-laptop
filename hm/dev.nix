{ lib, pkgs, ... }: 

{
  imports = [
  ];

  home.packages = with pkgs; [
    (callPackage ../pkgs/idea.nix {})
    jetbrains.pycharm
    git
    git-lfs
    gh
    visualvm
    zed-editor
    wakatime-cli
  ];

  programs = {
    direnv.enable = true;
    cargo = {
      enable = true;
      settings = {
        build = {
          rustc-wrapper = "${lib.getExe pkgs.sccache}";
        };
      };
    };
  };
}
