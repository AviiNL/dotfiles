{ pkgs ? import <nixpkgs> { } }: rec {
  # example = pkgs.callPackage ./example { };
  alsa-lib = pkgs.callPackage ./alsa-lib { };
  alsa-ucm-conf = pkgs.callPackage ./alsa-ucm-conf { };
}
