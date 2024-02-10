{ inputs, outputs, config, pkgs, ... }: {
  home.packages = with pkgs; [ winetricks nestopia-ue ];
}
