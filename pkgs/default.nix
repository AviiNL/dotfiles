{ pkgs ? import <nixpkgs> { } }: rec {
  # example = pkgs.callPackage ./example { };

  # # FIXME: These need to be done with an overlay or something instead of a full-blown package
  # # if this is here, it rebuilds literally every other package from source
  # alsa-lib = pkgs.callPackage ./alsa-lib { };
  # alsa-ucm-conf = pkgs.callPackage ./alsa-ucm-conf { };

  nestopia-ue = pkgs.callPackage ./nestopia-ue { };
  vscode = pkgs.callPackage ./vscode { };
  obsidian = pkgs.callPackage ./obsidian { };
  webcord-vencord = pkgs.callPackage ./webcord-vencord { };
  openvr = pkgs.callPackage ./openvr { };
  gamescope = pkgs.callPackage ./gamescope { };
  modrinth-app = pkgs.callPackage ./modrinth-app { };
  minecraft = pkgs.callPackage ./minecraft { };
}
