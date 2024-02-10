{ config, pkgs, ... }: {
  custom.software.kitty = {
    enable = true;
    nix-colors = true;
  };
}
