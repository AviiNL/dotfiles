{ config, lib, pkgs, modulesPath, ... }: {
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/fc3ef879-fb4f-45bb-9d8e-d7e581f39f1c";
    fsType = "btrfs";
    options = [ "subvol=root" "noatime" "compress=zstd" ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/fc3ef879-fb4f-45bb-9d8e-d7e581f39f1c";
    fsType = "btrfs";
    options = [ "subvol=home" "noatime" "compress=zstd" ];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/fc3ef879-fb4f-45bb-9d8e-d7e581f39f1c";
    fsType = "btrfs";
    options = [ "subvol=nix" "noatime" "compress=zstd" ];
  };

  fileSystems."/persist" = {
    device = "/dev/disk/by-uuid/fc3ef879-fb4f-45bb-9d8e-d7e581f39f1c";
    fsType = "btrfs";
    options = [ "subvol=persist" "noatime" "compress=zstd" ];
  };

  fileSystems."/var/log" = {
    device = "/dev/disk/by-uuid/fc3ef879-fb4f-45bb-9d8e-d7e581f39f1c";
    fsType = "btrfs";
    options = [ "subvol=log" "noatime" "compress=zstd" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/F1FE-7E94";
    fsType = "vfat";
  };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/66973f9c-d320-485a-8109-23f158b15016"; }];
}
