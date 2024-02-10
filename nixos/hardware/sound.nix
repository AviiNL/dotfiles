{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [ "${inputs.nix-gaming}/modules/pipewireLowLatency.nix" ];
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

    lowLatency = {
      # enable this module      
      enable = true;
      # defaults (no need to be set unless modified)
      quantum = 64;
      rate = 48000;
    };
  };

  environment.systemPackages = with pkgs; [ pavucontrol pulseaudio ];

  services.goxlr.enable = true;
}
