{ inputs, outputs, lib, config, pkgs, ... }: {
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;
  };

  environment.systemPackages = with pkgs; [
    goxlr-utility
    pavucontrol
    alsa-ucm-conf
  ];

  services.udev.packages = [ pkgs.goxlr-utility ];
  xdg.autostart.enable = true;
}
