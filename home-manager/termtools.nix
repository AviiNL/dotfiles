{ config, lib, pkgs, ... }: {
  home.packages = with pkgs; [ zellij calcurse mutt ];
}
