{ config, pkgs, ... }: {
  home.packages = with pkgs; [ dolphin qt5ct adwaita-qt breeze-icons ];
}
