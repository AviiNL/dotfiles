{ config, lib, pkgs, ... }: {
  imports = [ ./steam-compat.nix ];

  programs.steam = {
    enable = true;
    # gamescopeSession = { enable = true; };
    # extraCompatPackages = [ pkgs.proton-ge ];
    # package = pkgs.steam.override {
    #   # extraPkgs = [ pkgs.bumblebee pkgs.glxinfo pkgs.protontricks ];
    # };
  };

  programs.gamescope = { enable = true; };

  # Star Citizen Tweak
  boot.kernel.sysctl = {
    "vm.max_map_count" = 16777216;
    "fs.file-max" = 524288;
  };

  environment.systemPackages = with pkgs; [
    # modrinth-app
    minecraft
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
          # List package dependencies here
        ];
    })
  ];
}
