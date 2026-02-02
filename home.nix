{ config, lib, pkgs, ... }: 

{
  imports = [
    ./hm
    ./hm/catppuccin
  ];

  home.packages = with pkgs; [
    chromium
    prismlauncher
    pinta
  ];

  programs = {
    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-vkcapture
      ];
    };
  };

  theme = {
    flavor = "mocha";
  };

  home.stateVersion = "25.05";
}
