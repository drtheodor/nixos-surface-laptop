{
  pkgs,
  config,
  lib,
  ...
}: {
  options.theme = {
    flavor = lib.mkOption {
      description = '''';
      type = lib.types.str;
      example = lib.literalExample "mocha";
      default = "mocha";
    };
    accent = lib.mkOption {
      description = '''';
      type = lib.types.str;
      example = lib.literalExample "sky";
      default = "lavender";
    };

    colors = lib.mkOption {
      description = '''';
      type = lib.types.attrs;
      readOnly = true;
      default = let
        removeHash = builtins.substring 1 6;
        catppuccin = lib.pipe "${config.catppuccin.sources.palette}/palette.json" [
          builtins.readFile
          builtins.fromJSON
          (builtins.mapAttrs (
            _: flavor:
              (builtins.mapAttrs (_: color: removeHash color.hex) flavor.colors)
              // {
                accent = removeHash flavor.colors.${config.theme.accent}.hex;
              }
          ))
        ];
      in
        catppuccin
        // catppuccin.${config.theme.flavor}
        // {
          notable =
            if config.theme.flavor == "latte"
            then catppuccin.mocha
            else catppuccin.latte;
        };
    };

    #wallpaper = lib.mkOption {
    #  description = ''
    #    Location of the wallpaper to use throughout the system.
    #  '';
    #  type = lib.types.path;
    #  example = lib.literalExample "./wallpaper.png";
    #};
  };

  config.catppuccin = {
    enable = true;
    cursors.enable = true;
    inherit (config.theme) flavor accent;
  };

  config.qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum";
  };

  config.dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  config.home = {
    pointerCursor = {
      size = 24;
    };
    packages = with pkgs; [
      corefonts
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      nerd-fonts.jetbrains-mono
      nerd-fonts.noto
    ];
  };
  
  config.xdg.configFile = {
    "rofi/catppuccin-lavrent-mocha.rasi".source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/home/catppuccin/rofi.rasi;
    "waybar/style.css".source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/home/catppuccin/waybar.css;
  };

  config.fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      serif = ["Noto Serif"];
      sansSerif = ["Noto Sans"];
      monospace = ["JetBrainsMono Nerd Font Mono"];
      emoji = [];
    };
  };

  config.gtk = {
    enable = true;

    font = {
      name = "JetBrainsMono Nerd Font Propo";
      package = pkgs.nerd-fonts.jetbrains-mono;
      size = 10;
    };

    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";

    gtk3.extraConfig.Settings = ''
      gtk-application-prefer-dark-theme=1
    '';
    gtk4.extraConfig.Settings = ''
      gtk-application-prefer-dark-theme=1
    '';

    iconTheme = {
      name = lib.mkForce "Colloid-Teal-Dracula-Dark";
      package = pkgs.colloid-icon-theme.override {
        schemeVariants = ["dracula"];
        colorVariants = ["teal"];
      };
    };
  };
}
