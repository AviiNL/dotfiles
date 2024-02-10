{ inputs, outputs, config, pkgs, ... }: {

  imports = [ ./waybar ];

  home.packages = [ pkgs.swww ];

  wayland.windowManager.sway = {
    enable = true;
    extraConfig = ''
      output DP-1 pos 0 0
      output HDMI-A-2 pos 2560 180
      output HDMI-A-1 pos -1920 180

      workspace 1 output DP-1
      workspace 2 output HDMI-A-2
      workspace 3 output HDMI-A-1

      gaps inner 5
      gaps outer 3

      default_border pixel 3

      bar {
        swaybar_command waybar
      }
    '';
    config = rec {
      modifier = "Mod4";
      # Use kitty as default terminal
      terminal = "${pkgs.kitty}/bin/kitty";
      bars = [ ];
      startup = [
        # Launch Firefox on start
        { command = "firefox"; }
      ];

    };
  };
}
