{ inputs, config, lib, pkgs, ... }: {
  imports = [ ./steam-compat.nix ];

  programs.steam = { enable = true; };

  programs.gamescope = { enable = true; };

  # Star Citizen Tweak
  boot.kernel.sysctl = {
    "vm.max_map_count" = 16777216;
    "fs.file-max" = 524288;
  };

  environment.systemPackages = with pkgs; [
    modrinth-app
    # minecraft
    protontricks
    winetricks
    steam-run
    (lutris.override {
      extraLibraries = pkgs:
        [
          # List library dependencies here
        ];
      extraPkgs = pkgs:
        [
          inputs.nix-gaming.packages.${system}.wine-ge
          # List package dependencies here
        ];
    })
  ];
}
