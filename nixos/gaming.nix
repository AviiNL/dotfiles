{ config, lib, pkgs, ... }: {
  imports = [ ./steam-compat.nix ];

  programs.steam = {
    enable = true;
    gamescopeSession = { enable = true; };
    # extraCompatPackages = [ pkgs.proton-ge ];
    # package = pkgs.steam.override {
    #   # extraPkgs = [ pkgs.bumblebee pkgs.glxinfo pkgs.protontricks ];
    # };
  };

  environment.systemPackages = with pkgs; [
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
