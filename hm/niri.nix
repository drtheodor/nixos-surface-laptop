{ config, lib, pkgs, ... }: 

{
  imports = [
  ];

  home.packages = with pkgs; [
    rofi
    waybar
    mate.mate-polkit
    nautilus

    cliphist
    wl-clipboard
    wl-clip-persist
    wtype
    wl-screenrec
    wlr-randr
    nwg-displays

    gcr # needed for gnome keyring
  ];

  services = {
    gnome-keyring.enable = true;
    swaync.enable = true;
  };
}
