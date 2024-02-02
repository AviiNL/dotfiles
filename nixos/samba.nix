{ inputs, outputs, lib, config, pkgs, ... }: {

  environment.systemPackages = [ pkgs.cifs-utils ];
  fileSystems = {
    "/network/server/nas" = {
      device = "//192.168.0.2/Nas";
      fsType = "cifs";
      options = let
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,user,users";
      in ["${automount_opts},credentials=/etc/nixos/smb-secrets"];
    };
    "/network/server/plex" = {
      device = "//192.168.0.2/Plex";
      fsType = "cifs";
      options = let
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,user,users";
      in ["${automount_opts},credentials=/etc/nixos/smb-secrets"];
    };
  };

  services.gvfs = {
    enable = true;
    package = lib.mkForce pkgs.gnome3.gvfs;
  };
}
