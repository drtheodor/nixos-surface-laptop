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
    p7zip
  ];

  programs = {
    yazi = {
      enable = true;
      settings = {
      };
    };
    kitty = {
      enable = true;
      settings = {
        hide_window_decorations = true;
        confirm_os_window_close = 0;
      };
    };
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
    neovim = {
      enable = true;
      defaultEditor = true;
      extraConfig = ''
        :set tabstop=4
        :set shiftwidth=4
        :set expandtab
        :set relativenumber
      '';
    };
    fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting # Disable greeting
        fastfetch
      '';
      shellAliases = {
        ls = "eza";
        os-clean = "nh clean all && sudo journalctl --vacuum-time=7d";
        os-build = "nh os switch";
      };
      functions = {
        y = ''
          set tmp (mktemp -t "yazi-cwd.XXXXXX")
          command yazi $argv --cwd-file="$tmp"
          if read -z cwd < "$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
            builtin cd -- "$cwd"
          end
          rm -f -- "$tmp"
        '';
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
            "1" = "#80C6F8";
            "2" = "#6DD3C0";
            "3" = "#80C6F8";
            "4" = "#6DD3C0";
            "5" = "#80C6F8";
            "6" = "#6DD3C0";
          };
        };
        display = {
          separator = "";
          color = { keys = "34"; };
        };
        modules = [
          # https://github.com/NixOS/nix/issues/10082
          # https://github.com/strong-tree/dotfiles/blob/main/config/fastfetch/config.jsonc
{ type = "title"; format = builtins.fromJSON ''" \u001b[35m \u001b[1m\u001b[34mNIXOS \u001b[0m\u001b[30m─────────────────────────────────────────"''; }
          "break"

          { type = "custom"; format = builtins.fromJSON ''" \u001b[34m\u001b[44;30m  SYSTEM \u001b[0m\u001b[34m"''; }
          { type = "os"; key = builtins.fromJSON ''" \u001b[44;30m OS \u001b[0m\u001b[34;40m"''; format = builtins.fromJSON ''"\u001b[40m \u001b[37m{3}\u001b[0m\u001b[30m"''; }
          { type = "kernel"; key = builtins.fromJSON ''" \u001b[44;30m󰒋 KE \u001b[0m\u001b[34;40m"''; format = builtins.fromJSON ''"\u001b[40m \u001b[37m{2}\u001b[0m\u001b[30m"''; }
          { type = "uptime"; key = builtins.fromJSON ''" \u001b[44;30m󰔛 UP \u001b[0m\u001b[34;40m"''; format = builtins.fromJSON ''"\u001b[40m \u001b[37m{2}h {3}m\u001b[0m\u001b[30m"''; }
          { type = "command"; text = "~/.cache/fastfetch/packages.sh"; key = builtins.fromJSON ''" \u001b[44;30m󰏖 PK \u001b[0m\u001b[34;40m"''; format = builtins.fromJSON ''"\u001b[40m \u001b[37m{result}\u001b[0m\u001b[30m"''; }

          "break"

          { type = "custom"; format = builtins.fromJSON ''" \u001b[34m\u001b[44;30m 󰧨 SOFTWARE \u001b[0m\u001b[34m"''; }
          { type = "wm"; key = builtins.fromJSON ''" \u001b[44;30m WM \u001b[0m\u001b[34;40m"''; format = builtins.fromJSON ''"\u001b[40m \u001b[37m{1}\u001b[0m\u001b[30m"''; }
          { type = "shell"; key = builtins.fromJSON ''" \u001b[44;30m SH \u001b[0m\u001b[34;40m"''; format = builtins.fromJSON ''"\u001b[40m \u001b[37m{1}\u001b[0m\u001b[30m"''; }
          { type = "terminal"; key = builtins.fromJSON ''" \u001b[44;30m TR \u001b[0m\u001b[34;40m"''; format = builtins.fromJSON ''"\u001b[40m \u001b[37m{5}\u001b[0m\u001b[30m"''; }
          { type = "font"; key = builtins.fromJSON ''" \u001b[44;30m󰛖 FT \u001b[0m\u001b[34;40m"''; format = builtins.fromJSON ''"\u001b[40m \u001b[37m{2}\u001b[0m\u001b[30m"''; }

          "break"

          { type = "custom"; format = builtins.fromJSON ''" \u001b[34m\u001b[44;30m 󰍛 HARDWARE \u001b[0m\u001b[34m"''; }
          { type = "cpu"; key = builtins.fromJSON ''" \u001b[44;30m CP \u001b[0m\u001b[34;40m"''; format = builtins.fromJSON ''"\u001b[40m \u001b[37m{1}\u001b[0m\u001b[30m"''; }
          { type = "gpu"; key = builtins.fromJSON ''" \u001b[44;30m󰢮 GP \u001b[0m\u001b[34;40m"''; format = builtins.fromJSON ''"\u001b[40m \u001b[37m{2}\u001b[0m\u001b[30m"''; }
          { type = "memory"; key = builtins.fromJSON ''" \u001b[44;30m󰍛 RA \u001b[0m\u001b[34;40m"''; format = builtins.fromJSON ''"\u001b[40m \u001b[37m{1} / {2}\u001b[0m\u001b[30m"''; }
          { type = "disk"; key = builtins.fromJSON ''" \u001b[44;30m󰋊 DI \u001b[0m\u001b[34;40m"''; format = builtins.fromJSON ''"\u001b[40m \u001b[37m{1} / {2} ({9})\u001b[0m\u001b[30m"''; }

          "break"
          { type = "colors"; symbol = "circle"; block = { range = [1 6]; }; }
        ];
      };
    };
  };

  home.activation.fastFetchSystemPkgs = lib.hm.dag.entryAfter ["writeBoundary"] ''
    CACHE_DIR="~/.cache/fastfetch/packages/nix"
    rm -f $CACHE_DIR/run/current-system
    rm -f $CACHE_DIR/etc/profiles/per-user/${config.home.username}

    mkdir -p $CACHE_DIR/run/
    mkdir -p $CACHE_DIR/etc/profiles/per-user/

    for x in $(nix-store --query --requisites /run/current-system); do if [ -d $x ]; then echo $x ; fi ; done | cut -d- -f2- | egrep '([0-9]{1,}\.)+[0-9]{1,}' | egrep -v '\-doc$|-man$|-info$|-dev$|-bin$|^nixos-system-nixos-' | uniq | wc -l >> $CACHE_DIR/run/current-system

    for x in $(nix-store --query --requisites /etc/profiles/per-user/${config.home.username}); do if [ -d $x ]; then echo $x ; fi ; done | cut -d- -f2- | egrep '([0-9]{1,}\.)+[0-9]{1,}' | egrep -v '\-doc$|-man$|-info$|-dev$|-bin$' | uniq | wc -l >> $CACHE_DIR/etc/profiles/per-user/${config.home.username}
  '';

  xdg.cacheFile."fastfetch/packages.sh" = {
    text = ''
      BASE_DIR="~/.cache/fastfetch/packages/nix"
      
      SYS_PKGS="$(cat $BASE_DIR/run/current-system)"
      USER_PKGS="$(cat $BASE_DIR/etc/profiles/per-user/${config.home.username})"
      FLATPAK_PKGS="$(flatpak list | wc -l)"

      echo "$SYS_PKGS (system), $USER_PKGS (user), $FLATPAK_PKGS (flatpak)"
    '';

    executable = true;
  };
}
