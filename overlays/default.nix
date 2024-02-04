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
