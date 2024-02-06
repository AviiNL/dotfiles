{ config, lib, pkgs, ... }: {
  imports = [
    ./hyprland.nix
    ./waybar.nix
    #./wofi.nix
    ./ulauncher.nix
  ];
}
