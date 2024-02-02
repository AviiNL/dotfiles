{ inputs, outputs, config, pkgs, ... }:
let wofi = "${config.programs.wofi.package}/bin/wofi";
in {
  imports = [
    inputs.nix-colors.homeManagerModule
    inputs.hyprland.homeManagerModules.default
  ];

  home.packages = [
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
    inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland
    pkgs.xdg-utils
    pkgs.grim
    pkgs.slurp
    pkgs.swappy
    pkgs.wl-clipboard
    pkgs.jq
    pkgs.swww
    pkgs.wl-color-picker
  ];

  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys =
      [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;

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
        "col.inactive_border" = "rgba(${config.colorscheme.palette.base02}80)";
      };
      decoration = { rounding = 5; };
      misc = {
        vrr = 2;
        disable_hyprland_logo = 1;
      };
      windowrulev2 = [ "idleinhibit fullscreen, class:^(librewolf)$" ];
      monitor = [
        "DP-2, 2560x1440, 0x0, 1"
        "HDMI-A-1, 1920x1080, 2560x180, 1"
        "HDMI-A-2, 1920x1080, -1920x180, 1"
      ];
      workspace = [
        "1,monitor:DP-2,default:true"
        "2,monitor:HDMI-A-1,default:true"
        "3,monitor:HDMI-A-2,default:true"
      ];
      exec-once = [
        # Background processes
        "swww init"
        "swww img ~/Pictures/mario.gif"
        "hyprctl dispatch workspace 1"
        "${pkgs.dbus}/bin/dbus-update-activation-environment --systemd --all"
        "goxlr-daemon"
        # Startup applications
        "[workspace 2] discord"
      ];
      bind = [
        # Browsers and Terminal
        ''$mod, Return, exec, "kitty"''
        ''$mod, D, exec, "dolphin"'' # Return is too far away
        ''$mod, B, exec, "librewolf"''
        ''$mod Shift, B, exec, "nix run nixpkgs#chromium"''

        # Launcher
        "$mod, R, exec, ${wofi} -S drun"
        "$mod SHIFT, R, exec, ${wofi} -S run"

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

        # Window functions
        "$mod, Q, killactive"
        "$mod, F, fullscreen, 0"
        "$mod, F, exec, $notifycmd 'Fullscreen Mode'"
        "$mod, Space, togglefloating"
        "$mod, Space, centerwindow"
      ];
      bindm = [ "$mod, mouse:272, movewindow" "$mod, mouse:273, resizewindow" ];
    };
  };
}
