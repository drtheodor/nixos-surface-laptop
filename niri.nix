{ lib, pkgs, ... }:

{
  security.polkit.enable = true;

  environment.sessionVariables = {
    GDK_BACKEND = "wayland";
    #GTK_CSD = "0";
    QT_QPA_PLATFORM = "wayland;xcb";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
    XDG_SESSION_TYPE = "wayland";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_QPA_PLATFORMTHEME = "kvantum";
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };

  environment.systemPackages = with pkgs; [
    xwayland-satellite
  ];

  xdg.portal = {
    config.niri.default = ["gtk" "gnome"];

    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
    ];

    configPackages = [
      pkgs.niri
    ];
  };

  programs = {
    xwayland.enable = true;
    dconf.enable = true;
  };

  services = {
    displayManager = {
      defaultSession = "niri";
      sessionPackages = with pkgs; [
        niri
      ];
    };
    displayManager.sddm = {
      enable = true;
      package = lib.mkForce pkgs.kdePackages.sddm;
      wayland.enable = true;
    };
  };
}
