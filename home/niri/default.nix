{ config, lib, pkgs, ... }: 

{
  imports = [
  ];

  home.packages = with pkgs; [
    rofi
    waybar
    mate.mate-polkit
    nautilus
    file-roller

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

  xdg.configFile = {
    "niri/config.kdl".source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/home/niri/config.kdl;
    "rofi/config.rasi".source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/home/niri/rofi.rasi;
    "waybar/config.jsonc".source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/home/niri/waybar.jsonc;
    "waybar/volume.sh".source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/home/niri/waybar/volume.sh;
    "waybar/cava.sh".source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/home/niri/waybar/cava.sh;
  };
}
