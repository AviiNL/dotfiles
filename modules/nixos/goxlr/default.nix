{ lib, pkgs, config, ... }:
with lib;
let cfg = config.services.goxlr;
in {
  options.services.goxlr = { enable = mkEnableOption "goxlr service"; };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ goxlr-utility ];
    services.udev.packages = [ pkgs.goxlr-utility ];
    systemd.user.services.goxlr = {
      serviceConfig = {
        Type = "exec";
        ExecStart = "${pkgs.goxlr-utility}/bin/goxlr-daemon";
      };
      wantedBy = [ "graphical-session.target" ];
    };
  };
}
