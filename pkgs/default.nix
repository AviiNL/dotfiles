{ pkgs ? import <nixpkgs> { } }: rec {
  # example = pkgs.callPackage ./example { };

  # # FIXME: These need to be done with an overlay or something instead of a full-blown package
  # # if this is here, it rebuilds literally every other package from source
  # alsa-lib = pkgs.callPackage ./alsa-lib { };
  # alsa-ucm-conf = pkgs.callPackage ./alsa-ucm-conf { };

  nestopia-ue = pkgs.callPackage ./nestopia-ue { };
}
