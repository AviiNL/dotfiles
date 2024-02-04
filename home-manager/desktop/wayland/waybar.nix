{ outputs, config, lib, pkgs, ... }:

let
  # Dependencies
  cat = "${pkgs.coreutils}/bin/cat";
  cut = "${pkgs.coreutils}/bin/cut";
  find = "${pkgs.findutils}/bin/find";
  grep = "${pkgs.gnugrep}/bin/grep";
  pgrep = "${pkgs.procps}/bin/pgrep";
  tail = "${pkgs.coreutils}/bin/tail";
  wc = "${pkgs.coreutils}/bin/wc";
  xargs = "${pkgs.findutils}/bin/xargs";
  timeout = "${pkgs.coreutils}/bin/timeout";
  ping = "${pkgs.iputils}/bin/ping";

  jq = "${pkgs.jq}/bin/jq";
  systemctl = "${pkgs.systemd}/bin/systemctl";
  journalctl = "${pkgs.systemd}/bin/journalctl";
  playerctl = "${pkgs.playerctl}/bin/playerctl";
  playerctld = "${pkgs.playerctl}/bin/playerctld";
  pavucontrol = "${pkgs.pavucontrol}/bin/pavucontrol";
  wofi = "${pkgs.wofi}/bin/wofi";

  # Function to simplify making waybar outputs
  jsonOutput = name:
    { pre ? "", text ? "", tooltip ? "", alt ? "", class ? "", percentage ? ""
    }:
    "${
      pkgs.writeShellScriptBin "waybar-${name}" ''
        set -euo pipefail
        ${pre}
        ${jq} -cn \
          --arg text "${text}" \
          --arg tooltip "${tooltip}" \
          --arg alt "${alt}" \
          --arg class "${class}" \
          --arg percentage "${percentage}" \
          '{text:$text,tooltip:$tooltip,alt:$alt,class:$class,percentage:$percentage}'
      ''
    }/bin/waybar-${name}";

  hasSway = config.wayland.windowManager.sway.enable;
  sway = config.wayland.windowManager.sway.package;
  hasHyprland = config.wayland.windowManager.hyprland.enable;
  hyprland = config.wayland.windowManager.hyprland.package;
in {

  home.packages = [ pkgs.playerctl ];

  # Let it try to start a few more times
  systemd.user.services.waybar = { Unit.StartLimitBurst = 30; };
  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oa: {
      mesonFlags = (oa.mesonFlags or [ ]) ++ [ "-Dexperimental=true" ];
    });
    systemd.enable = true;
    settings = {
      primary = {
        # mode = "dock";
        layer = "top";
        height = 28;
        margin = "6";
        position = "top";
        modules-left = [ "custom/menu" ]
          ++ (lib.optionals hasSway [ "sway/workspaces" "sway/mode" ])
          ++ (lib.optionals hasHyprland [
            "hyprland/workspaces"
            "hyprland/submap"
          ]) ++ [ "custom/currentplayer" "custom/player" ];

        modules-center = [
          # "cpu"
          # "custom/gpu"
          # "memory"
          "clock"
          # "pulseaudio"
          # "battery"
          # "custom/unread-mail"
          #"custom/gpg-agent"
        ];

        modules-right = [
          # "custom/gammastep" TODO: currently broken for some reason
          # "custom/tailscale-ping"
          "pulseaudio"

          "cpu"
          "temperature"
          "custom/gpu"
          "memory"

          # "battery"

          "network"
          "tray"
          "custom/hostname"
        ];

        clock = {
          interval = 1;
          format = "<big>{:%H:%M:%S}</big>";
          format-alt = "{:%a, %d %b %Y %H:%M:%S}";
          on-click-left = "mode";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
        };

        cpu = {
          format = "   {usage} %";
          tooltip-format = " 0°C";
        };

        temperature = {
          interval = 3;
          hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input";
          format = " {temperatureC}°C";
        };

        # nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader

        "custom/gpu" = {
          interval = 2;
          return-type = "json";
          exec = jsonOutput "custom/gpu" {
            text =
              "󰒋 $(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader)";
            # format = "󰒋  {}";
            tooltip =
              " $(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader)°C";
          };
          on-click = "nvidia-settings";
        };
        memory = {
          format = "  {} %";
          interval = 2;
        };

        pulseaudio = {
          format = "{icon}  {volume}%";
          format-muted = "   0%";
          format-icons = {
            headphone = "󰋋";
            headset = "󰋎";
            portable = "";
            default = [ "" "" "" ];
          };
          on-click = pavucontrol;
        };
        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "󰒳";
            deactivated = "󰒲";
          };
        };
        "sway/window" = { max-length = 20; };
        network = {
          interval = 3;
          format-wifi = " {essid}";
          format-ethernet = "󰈁";
          format-disconnected = "";
          tooltip-format = ''
            {ifname}
            {ipaddr}/{cidr}
            Up: {bandwidthUpBits}
            Down: {bandwidthDownBits}'';
          on-click = "";
        };
        "custom/menu" = let
          isFullScreen = if hasHyprland then
            "${hyprland}/bin/hyprctl activewindow -j | ${jq} -e '.fullscreen' &>/dev/null"
          else
            "false";
        in {
          interval = 1;
          return-type = "json";
          exec = jsonOutput "menu" {
            text = "";
            tooltip = ''
              $(${cat} /etc/os-release | ${grep} PRETTY_NAME | ${cut} -d '"' -f2)'';
            class = "$(if ${isFullScreen}; then echo fullscreen; fi)";
          };
          # on-click = "${wofi} -S drun";
          on-click-right = lib.concatStringsSep ";" ((lib.optional hasHyprland
            "${hyprland}/bin/hyprctl dispatch togglespecialworkspace")
            ++ (lib.optional hasSway "${sway}/bin/swaymsg scratchpad show"));

        };
        "custom/hostname" = {
          exec = "echo $USER@$HOSTNAME";
          on-click = "${systemctl} --user restart waybar";
        };
        "custom/currentplayer" = {
          interval = 2;
          return-type = "json";
          exec = jsonOutput "currentplayer" {
            pre = ''
              player="$(${playerctl} status -f "{{playerName}}" 2>/dev/null || echo "No player active" | ${cut} -d '.' -f1)"
              count="$(${playerctl} -l 2>/dev/null | ${wc} -l)"
              if ((count > 1)); then
                more=" +$((count - 1))"
              else
                more=""
              fi
            '';
            alt = "$player";
            tooltip = "$player ($count available)";
            text = "$more";
          };
          format = "{icon}{}";
          format-icons = {
            "No player active" = " ";
            "Celluloid" = "󰎁 ";
            "spotify" = "󰓇 ";
            "ncspot" = "󰓇 ";
            "qutebrowser" = "󰖟 ";
            "firefox" = " ";
            "discord" = " 󰙯 ";
            "sublimemusic" = " ";
            "kdeconnect" = "󰄡 ";
            "chromium" = " ";
          };
          on-click = "${playerctld} shift";
          on-click-right = "${playerctld} unshift";
        };
        "custom/player" = {
          exec-if = "${playerctl} status 2>/dev/null";
          exec = jsonOutput "custom/player" {
            text =
              "$(${playerctl} metadata --format '{{title}} - {{artist}} ({{album}})' 2>/dev/null | jq -sRr @html)";
            alt = "$(${playerctl} metadata --format '{{status}}')";
            tooltip =
              "$(${playerctl} metadata --format '{{title}} - {{artist}} ({{album}})' 2>/dev/null | jq -sRr @html)";
            # ${playerctl} metadata --format '{"text": "{{title}} - {{artist}}", "alt": "{{status}}", "tooltip": "{{title}} - {{artist}} ({{album}})"}' | jq -sRr @html 2>/dev/null
          };
          return-type = "json";
          interval = 2;
          max-length = 80;
          format = "{icon} {}";
          format-icons = {
            "Playing" = "󰐊";
            "Paused" = "󰏤 ";
            "Stopped" = "󰓛";
          };
          on-click = "${playerctl} play-pause";
        };
      };

    };
    # Cheatsheet:
    # x -> all sides
    # x y -> vertical, horizontal
    # x y z -> top, horizontal, bottom
    # w x y z -> top, right, bottom, left
    style = let
      inherit (config.colorscheme) palette;
      # css
    in ''
      * {
        font-family: ${config.fontProfiles.regular.family}, ${config.fontProfiles.monospace.family};
        font-size: 9pt;
        padding: 0;
        margin: 0 0.4em;
      }

      window#waybar {
        padding: 0;
        opacity: 0.75;
        border-radius: 0.5em;
        background-color: #${palette.base00};
        color: #${palette.base05};
      }
      .modules-left {
        margin-left: -0.65em;
      }
      .modules-right {
        margin-right: -0.65em;
      }

      #workspaces button {
        background-color: #${palette.base00};
        color: #${palette.base05};
        padding-left: 0.4em;
        padding-right: 0.4em;
        margin-top: 0.15em;
        margin-bottom: 0.15em;
      }
      #workspaces button.hidden {
        background-color: #${palette.base00};
        color: #${palette.base04};
      }
      #workspaces button.focused,
      #workspaces button.active {
        background-color: #${palette.base0A};
        color: #${palette.base00};
      }

      #clock {
        background-color: #${palette.base01};
        color: #${palette.base0A};
        padding-right: 1em;
        padding-left: 1em;
        border-radius: 0.5em;
        font-weight: 600;
      }

      #custom-menu {
        background-color: #${palette.base01};
        padding-right: 1.5em;
        padding-left: 1em;
        margin-right: 0;
        border-radius: 0.5em;
      }
      #custom-menu.fullscreen {
        background-color: #${palette.base0C};
        color: #${palette.base00};
      }
      #custom-hostname {
        background-color: #${palette.base01};
        padding-right: 1em;
        padding-left: 1em;
        margin-left: 0;
        border-radius: 0.5em;
      }
      #custom-currentplayer {
        padding-right: 0;
      }
      #tray {
        color: #${palette.base05};
      }
      #custom-gpu, #cpu, #memory {
        margin-left: 0.05em;
        margin-right: 0.55em;
      }
    '';
  };
}
