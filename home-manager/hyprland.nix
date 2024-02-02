{ inputs, outputs, config, pkgs, ... }: {

  # add ./common here when we got it
  imports = [
    inputs.nix-colors.homeManagerModule
    inputs.hyprland.homeManagerModules.default
  ];

  colorscheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;

  home.packages = [
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
    inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland
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

    # settings = [
    #   bind = [

    #   ]
    # ];

    extraConfig = let wofi = "${config.programs.wofi.package}/bin/wofi";
    in ''
      # ASCII Art from https://fsymbols.com/generators/carty/
      input {
        kb_layout = us
      }

      general {
       	gaps_in = 3
       	gaps_out = 5
       	border_size = 3
        col.active_border=0xff${config.colorscheme.palette.base07}
        col.inactive_border=0xff${config.colorscheme.palette.base02}
      }

      decoration {
        rounding=5
      }

      misc {
        vrr = 2
        disable_hyprland_logo = 0;
      }

      $notifycmd = notify-send -h string:x-canonical-private-synchronous:hypr-cfg -u low

      monitor=DP-2, 2560x1440, 0x0, 1
      monitor=HDMI-A-1, 1920x1080, 2560x0, 1
      monitor=HDMI-A-2, 1920x1080, -1920x0, 1

      workspace = 1,monitor:DP-2,default:true
      workspace = 2,monitor:HDMI-A-1,default:true
      workspace = 3,monitor:HDMI-A-2,default:true

      # Background processes
      exec-once = hyprctl dispatch workspace 1
      exec-once = ${pkgs.dbus}/bin/dbus-update-activation-environment --systemd --all
      exec-once = goxlr-daemon

      # Foreground applications on start
      exec-once = [workspace 2 silent] discord

      # Shortcuts
      bind = SUPER, Return, exec, "kitty"
      bind = SUPER, B, exec, "librewolf"
      bind = SUPERShift, B, exec, "chromium"
      bind = SUPER, E, exec, "dolphin"
      bind = SUPER, R, exec, ${wofi} -S drun

      # bind = SUPER, w, exec, makoctl dismiss

      bind = Alt, Tab, cyclenext
      bind = Alt, Tab, bringactivetotop
      bind = Alt Shift, Tab, cyclenext, prev
      bind = Alt Shift, Tab, bringactivetotop

      bind = SUPERSHIFT,Left,movewindow,l
      bind = SUPERSHIFT,Right,movewindow,r
      bind = SUPERSHIFT,Up,movewindow,u
      bind = SUPERSHIFT,Down,movewindow,d

      bind = SUPERSHIFT, 1, movetoworkspacesilent, 1
      bind = SUPERSHIFT, 2, movetoworkspacesilent, 2
      bind = SUPERSHIFT, 3, movetoworkspacesilent, 3

      bind = SUPER, Q, killactive,
      bind = SUPER, F, fullscreen, 0
      bind = SUPER, F, exec, $notifycmd 'Fullscreen Mode'
      bind = SUPER, S, pseudo,
      bind = SUPER, S, exec, $notifycmd 'Pseudo Mode'
      bind = SUPER, Space, togglefloating,
      bind = SUPER, Space, centerwindow,

      bindm=SUPER, mouse:272, movewindow
      bindm=SUPER, mouse:273, resizewindow

      binde = SUPERALT, h, resizeactive, -20 0
      binde = SUPERALT, l, resizeactive, 20 0
      binde = SUPERALT, k, resizeactive, 0 -20
      binde = SUPERALT, j, resizeactive, 0 20

      # Disable idle timeouts when librewolf is in fullscreen
      windowrulev2 = idleinhibit fullscreen, class:^(librewolf)$
    '';
  };
}
