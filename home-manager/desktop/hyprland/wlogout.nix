{ config, lib, pkgs, ... }: {
  programs.wlogout = {
    enable = true;
    layout = [
      {
        "label" = "lock";
        "action" = "swaylock";
        "text" = "Lock";
        "keybind" = "l";
      }
      {
        "label" = "hibernate";
        "action" = "systemctl hibernate";
        "text" = "Hibernate";
        "keybind" = "h";
      }
      {
        "label" = "logout";
        "action" = "loginctl terminate-user $USER";
        "text" = "Logout";
        "keybind" = "e";
      }
      {
        "label" = "shutdown";
        "action" = "systemctl poweroff";
        "text" = "Shutdown";
        "keybind" = "s";
      }
      {
        "label" = "suspend";
        "action" = "systemctl suspend";
        "text" = "Suspend";
        "keybind" = "u";
      }
      {
        "label" = "reboot";
        "action" = "systemctl reboot";
        "text" = "Reboot";
        "keybind" = "r";
      }
    ];
    style = let inherit (config.colorscheme) palette;
    in ''
      * {
      	background-image: none;
      }
      window {
      	background-color: rgba(12, 12, 12, 0.8);
      }
      button {
        margin: 3px;
        color: #${palette.base05};
      	background-color: #${palette.base00};
      	border-style: solid;
      	border-color: #${palette.base02};
      	border-width: 3px;
        border-radius: 5px;
      	background-repeat: no-repeat;
      	background-position: center;
      	background-size: 25%;
      }

      button:hover {
      	background-color: #${palette.base00};
        border-color: #${palette.base07};
      	outline-style: none;
      }

      #lock {
          background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/lock.png"));
      }

      #logout {
          background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/logout.png"));
      }

      #suspend {
          background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/suspend.png"));
      }

      #hibernate {
          background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/hibernate.png"));
      }

      #shutdown {
          background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/shutdown.png"));
      }

      #reboot {
          background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/reboot.png"));
      }
    '';
  };
}
