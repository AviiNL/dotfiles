{ inputs, outputs, config, pkgs, ... }: {
  home.packages = with pkgs; [
    inputs.nix-gaming.packages.${pkgs.hostPlatform.system}.wine-ge
    inputs.nix-gaming.packages.${pkgs.hostPlatform.system}.star-citizen
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
