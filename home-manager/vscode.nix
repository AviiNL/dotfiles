{ config, pkgs, ... }: {
  custom.software.vscode = {
    enable = true;
    nix-colors = true;
  };
}
