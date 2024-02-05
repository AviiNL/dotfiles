{ inputs, outputs, config, pkgs, ... }: {
  home.packages = [
    inputs.nix-gaming.packages.${pkgs.hostPlatform.system}.wine-ge
    pkgs.directx-shader-compiler
    pkgs.winetricks
  ];
}
