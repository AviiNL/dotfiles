{ inputs, outputs, config, pkgs, ... }:
let wofi = "${config.programs.wofi.package}/bin/wofi";
in {
  imports = [ inputs.hyprland.homeManagerModules.default ];

  home.packages = [
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
    inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland
    pkgs.xdg-desktop-portal-wlr
    pkgs.xdg-utils
    pkgs.grim
    pkgs.slurp
    pkgs.swappy
    pkgs.wl-clipboard
    pkgs.jq
    pkgs.swww
    pkgs.wl-color-picker
    pkgs.xorg.xrandr
  ];

  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-wlr ];

  wayland.windowManager.hyprland =
    let plugins = inputs.hyprland-plugins.packages.${pkgs.system};
    in {
      enable = true;
      xwayland.enable = true;
      systemd.enable = true;
      package = inputs.hyprland.packages."${pkgs.system}".hyprland;

      plugins = [
        # plugins.hyprtrails
        # plugins.hyprbars
      ];

      settings = {
        "$mod" = "SUPER";
        "$notifycmd" =
          "notify-send -h string:x-canonical-private-synchronous:hypr-cfg -u low";
        input = { kb_layout = "us"; };
        general = {
          gaps_in = 3;
          gaps_out = 5;
          border_size = 3;
          "col.active_border" = "rgba(${config.colorscheme.palette.base07}80)";
          "col.inactive_border" =
            "rgba(${config.colorscheme.palette.base02}80)";
        };
        decoration = { rounding = 5; };
        # misc = {
        #   vrr = 0;
        #   disable_hyprland_logo = 1;
        # };
        monitor = [
          "DP-2, 2560x1440@165, 0x0, 1"
          #"HDMI-A-1, disable"
          #"HDMI-A-2, disable"

          "HDMI-A-1, 1920x1080@60, 2560x180, 1"
          "HDMI-A-2, 1920x1080@60, -1920x180, 1"

          # Gaming modus (or something)
          # "DP-2, 2560x1440@165, 0x0, 1"
          # "HDMI-A-1, 1920x1080@60, 3560x180, 1"
          # "HDMI-A-2, 1920x1080@60, -2920x180, 1"
        ];
        workspace = [
          "1,monitor:DP-2,default:true"
          "2,monitor:HDMI-A-1,default:false"
          "3,monitor:HDMI-A-2,default:false"
        ];
        exec-once = [
          # Background processes
          # "xrandr --output DP-2 --primary --preferred"
          "hyprctl setcursor Simp1e-Adw-Dark 1"
          "swww init ; sleep 1 ; swww img ~/Pictures/mario.gif"
          "hyprctl dispatch workspace 1"
          "${pkgs.dbus}/bin/dbus-update-activation-environment --systemd --all"
          "[silent] ulauncher"
          # Startup applications
          "[workspace 2] webcord"
        ];
        bind = [
          # Browsers and Terminal
          "$mod, Return, exec, kitty"
          "$mod, E, exec, kitty"
          "$mod, D, exec, nemo"
          "$mod, C, exec, code"
          "$mod, B, exec, firefox"
          "$mod SHIFT, B, exec, nix-shell -p chromium --command chromium"

          # Launcher
          # "$mod, R, exec, ${wofi} -S drun"
          # "$mod SHIFT, R, exec, ${wofi} -S run"
          "$mod, R, exec, ulauncher-toggle"
          "$modS SHIFT, R, exec, ulauncher" # incase it crashed or something

          # Region Screenshot Clipboard
          '',Print, exec, grim -g "$(slurp -d)" - | wl-copy''
          # Region Screenshot Edit
          ''SHIFT, Print, exec, grim -g "$(slurp -d)" - | swappy -f -''

          # Active Window Screenshot Clipboard
          ''
            CTRL, Print, exec, grim -g "$(hyprctl activewindow -j | jq -r '.at | join(",")') $(hyprctl activewindow -j | jq -r '.size | join("x")')" - | wl-copy''

          # Active Window Screenshot Edit
          ''
            SHIFT CTRL,Print, exec, grim -g "$(hyprctl activewindow -j | jq -r '.at | join(",")') $(hyprctl activewindow -j | jq -r '.size | join("x")')" - | swappy -f -''

          # Fullscreen screenshot
          "$mod, Print, exec, grim - | wl-copy"
          "SHIFT $mod, Print, exec, grim - | swappy -f -"

          # Media
          ",XF86AudioNext,exec,playerctl next"
          ",XF86AudioPrev,exec,playerctl previous"
          ",XF86AudioPlay,exec,playerctl play-pause"
          ",XF86AudioStop,exec,playerctl stop"

          # Volume
          ",XF86AudioRaiseVolume,exec,pactl set-sink-volume @DEFAULT_SINK@ +5%"
          ",XF86AudioLowerVolume,exec,pactl set-sink-volume @DEFAULT_SINK@ -5%"

          # Window functions
          "$mod, Q, killactive"
          "$mod, F, fullscreen, 0"
          "$mod, F, exec, $notifycmd 'Fullscreen Mode'"
          "$mod, Space, togglefloating"
          "$mod, Space, centerwindow"

          "$mod, H, movetoworkspace, special"

          # "$mod Control, 1, movecursor, -1960 720"
          # "$mod Control, 2, movecursor, 1280 720"
          # "$mod Control, 3, movecursor, 4520 720"

          "$mod, Left, movefocus,l"
          "$mod, Right, movefocus,r"
          "$mod, Up, movefocus,u"
          "$mod, Down, movefocus,d"
          "$mod Control, Left, focusmonitor,l"
          "$mod Control, Right, focusmonitor,r"
          "$mod Control, Up, focusmonitor,u"
          "$mod Control, Down, focusmonitor,d"
          "$mod, Backspace, exec, hyprctl dispatch exit"
        ];
        bindm =
          [ "$mod, mouse:272, movewindow" "$mod, mouse:273, resizewindow" ];
      };
    };
}
