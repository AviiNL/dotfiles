{ config, lib, pkgs, modulesPath, ... }: {

  # NVIDIA
  hardware = {
    nvidia = {
      open = false;
      modesetting = { enable = true; };
      nvidiaSettings = true;

      package = config.boot.kernelPackages.nvidiaPackages.production;
      # prime = {
      #   sync.enable = true;
      #   nvidiaBusId = "PCI:1:0:0";
      #   amdgpuBusId = "PCI:5:0:0";
      # };
    };

    opengl = { driSupport32Bit = true; };
  };

  # boot.initrd.availableKernelModules = [
  #   #"nouveau"
  #   "nvidia"
  #   "nvidia_modeset"
  #   "nvidia_drm"
  #   "nvidia_uvm"
  # ];

  # boot.initrd.kernelModules = [
  #   #"nouveau"
  #   "nvidia"
  #   "nvidia_modeset"
  #   "nvidia_drm"
  #   "nvidia_uvm"
  # ];

  # boot.kernelParams = [
  #   #"nouveau.config=NvGspRm=1"
  #   "modeset=1"
  #   "fbdev=1"
  # ];

  # boot.kernel.sysctl = {
  #   "vm.max_map_count" = 16777216;
  #   "fs.file-max" = 524288;
  # };

  services.xserver = { videoDrivers = [ "nvidia" ]; };

  # hardware = {
  #   opengl = {
  #     enable = true;
  #     driSupport = true;
  #     driSupport32Bit = true;
  #     # extraPackages = with pkgs; [ mesa.drivers ];
  #     extraPackages = with pkgs; [
  #       vaapiVdpau
  #       libvdpau-va-gl
  #       nvidia-vaapi-driver
  #       libGL
  #     ];
  #     setLdLibraryPath = true;
  #   };
  #   nvidia = {
  #     open = false;
  #     modesetting.enable = true;
  #     nvidiaSettings = true;

  #     package = config.boot.kernelPackages.nvidiaPackages.production;

  #     powerManagement = {
  #       enable = false;
  #       finegrained = false;
  #     };
  #   };
  # };
}
