# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [
    "nvme"
    "ahci"
    "xhci_pci"
    "usb_storage"
    "usbhid"
    "sd_mod"
    "nouveau"
    "nvidia_drm"
    "v4l2loopback"
  ];

  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.initrd.systemd.enable = true;
  boot.kernelModules = [ "kvm-amd" "nvidia_drm" "v4l2loopback" ];
  boot.kernelParams = [ "modeset=1" "fbdev=1" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.v4l2loopback.out ];

  # Set initial kernel module settings
  boot.extraModprobeConfig = ''
    # exclusive_caps: Skype, Zoom, Teams etc. will only show device when actually streaming
    # card_label: Name of virtual camera, how it'll show up in Skype, Zoom, Teams
    # https://github.com/umlaeute/v4l2loopback
    options v4l2loopback exclusive_caps=1 card_label="Virtual Camera"
  '';

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

  hardware = {
    cpu.amd.updateMicrocode =
      lib.mkDefault config.hardware.enableRedistributableFirmware;
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        vaapiVdpau
        libvdpau-va-gl
        nvidia-vaapi-driver
      ];
    };
    nvidia = {
      open = false;
      modesetting.enable = true;
      nvidiaSettings = true;

      package = config.boot.kernelPackages.nvidiaPackages.production;

      powerManagement = {
        enable = false;
        finegrained = false;
      };
    };
    opentabletdriver = {
      enable = true;
      daemon.enable = true;
    };
  };

  services.xserver = { videoDrivers = [ "nvidia" ]; };

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp39s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
