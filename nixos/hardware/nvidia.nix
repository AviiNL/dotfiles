{ config, lib, pkgs, modulesPath, ... }: {

  # NVIDIA
  hardware = {
    nvidia = {
      open = false;
      modesetting = { enable = true; };
      nvidiaSettings = true;

      package = config.boot.kernelPackages.nvidiaPackages.production;
    };

    opengl = {
      driSupport32Bit = true;

      # Required for video decoding/playback
      extraPackages = with pkgs; [
        vaapiVdpau
        libvdpau-va-gl
        nvidia-vaapi-driver
        libGL
      ];
      setLdLibraryPath = true;
    };
  };

  boot.initrd.kernelModules = [ "nvidia_modeset" "nvidia_drm" "nvidia_uvm" ];
  boot.kernelParams = [ "modeset=1" "fbdev=1" ];

  services.xserver = { videoDrivers = [ "nvidia" ]; };
}
