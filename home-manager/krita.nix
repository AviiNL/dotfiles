{ config, lib, pkgs, ... }: {
  home.packages = with pkgs; [ opentabletdriver krita ];
}
