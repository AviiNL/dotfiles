{ config, lib, pkgs, modulesPath, ... }: {

  boot.initrd.availableKernelModules = [
    #"nouveau"
    "nvidia"
    "nvidia_modeset"
    "nvidia_drm"
    "nvidia_uvm"
  ];

  boot.initrd.kernelModules = [
    #"nouveau"
    "nvidia"
    "nvidia_modeset"
    "nvidia_drm"
    "nvidia_uvm"
  ];

  boot.kernelParams = [
    #"nouveau.config=NvGspRm=1"
    "modeset=1"
    "fbdev=1"
  ];

  services.xserver = { videoDrivers = [ "nvidia" ]; };

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      # extraPackages = with pkgs; [ mesa.drivers ];
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
  };
}
