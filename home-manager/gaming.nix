{ inputs, outputs, config, pkgs, ... }: {
  home.packages = with pkgs; [
    inputs.nix-gaming.packages.${system}.wine-ge
    inputs.nix-citizen.packages.${system}.star-citizen
    winetricks
    nestopia-ue
    # (retroarch.override {
    #   cores = with libretro; [
    #     mesen
    #     snes9x
    #     # dolphin
    #   ];
    # })
  ];
}
