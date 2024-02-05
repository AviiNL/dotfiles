{ inputs, outputs, config, lib, pkgs, ... }: {
  imports = [ ./sound.nix ];

  services.xserver.enable = true;
  services.xserver.wacom.enable = true;
  services.xserver.displayManager.gdm.enable = true;

  # services.greetd = {
  #   enable = true;
  #   settings = rec {
  #     initial_session = {
  #       command = "Hyprland";
  #       user = "aviinl";
  #     };
  #     default_session = initial_session;
  #   };
  # };

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";
  environment.sessionVariables.QT_QPA_PLATFORM = "wayland";
  environment.sessionVariables.QT_QPA_PLATFORMTHEME = "qt5ct";
  environment.sessionVariables.GTK_THEME = "Adwaita:dark";
}
