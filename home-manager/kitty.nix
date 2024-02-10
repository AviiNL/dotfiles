# https://github.com/jupblb/nix-config/blob/main/home-manager/kitty.nix

{ config, pkgs, ... }: {
  custom.software.kitty = {
    enable = true;
    nix-colors = true;
  };
}
