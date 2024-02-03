{ inputs, outputs, config, pkgs, ... }: {
  home.packages = [
    inputs.nix-gaming.packages.${pkgs.hostPlatform.system}.wine-ge
    pkgs.winetricks
  ];
}
