{ config, lib, pkgs, ... }: 

{
  imports = [
  ];

  home.packages = with pkgs; [
    playerctl
    pavucontrol
    cava
    brightnessctl
    htop
    onefetch
    eza
  ];

  programs = {
    alacritty = {
      enable = true;
      settings = {
        window.decorations = "none";
        window.padding = {
          x = 8;
          y = 8;
        };
        terminal.shell = "${lib.getExe pkgs.fish}";
      };
    };
    fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting # Disable greeting
      '';
      shellInitLast = "fastfetch";
      shellAliases = {
        ls = "eza";
        os-clean = "nh clean all && sudo journalctl --vacuum-time=7d";
        os-build = "nh os switch";
      };
    };
    btop.enable = true;
    fastfetch = {
      enable = true;
      settings = {
        logo = {
          # https://www.reddit.com/r/NixOS/comments/1osxsjb/comment/no0z52w/
          source = "${./logo.txt}";
          type = "file";
          color = {
            "1" = "#F3A2BB";
            "2" = "#EEAE7B";
            "3" = "#B5C77D";
            "4" = "#6DD3C0";
            "5" = "#80C6F8";
            "6" = "#C7AFF5";
          };
        };
        modules = [
          "title"
          "separator"
          "os"
          "host"
          "uptime"
          "shell"
          "terminal"
          "packages"
        ];
      };
    };
  };
}
