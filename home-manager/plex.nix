{ config, lib, pkgs, ... }: {
  home.packages = with pkgs; [ plex-media-player plexamp ];
}
