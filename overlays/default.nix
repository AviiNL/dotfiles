{ outputs, inputs }:
let
  addPatches = pkg: patches:
    pkg.overrideAttrs
    (oldAttrs: { patches = (oldAttrs.patches or [ ]) ++ patches; });
in {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs { pkgs = final; };

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev:
    {

      # FIXME: This aint it either...
      # alsa-lib = addPatches prev.alsa-lib [ ./alsa-fix.diff ];
      # alsa-ucm-conf = addPatches prev.alsa-ucm-conf [ ./alsa-fix.diff ];

      # example = prev.example.overrideAttrs (oldAttrs: rec {
      # ...
      # });

      # nestopia = prev.nestopia.overrideAttrs (oldAttrs: {
      #   version = "1.52.0";
      #   src = prev.fetchFromGitHub {
      #     owner = "0ldsk00l";
      #     repo = "nestopia";
      #     rev = "d897bfdc047bf6309b46c12073dd7f0373fb60ba";
      #     sha256 = "sha256-kd5hZ88fCLL8ysGMj7HsrSA7eCI5SL2xxiRXJiZqBZ8=";
      #   };
      #   patches = [ ];

      #   buildPhase = ''
      #     autoreconf -vif
      #     ./configure
      #     make
      #   '';

      #   installPhase = ''
      #     mkdir -p $out/{bin,share/nestopia}
      #     make install PREFIX=$out
      #   '';
      # });
    };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
