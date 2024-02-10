{ inputs, outputs, config, lib, pkgs, ... }: {
  imports = [ ./sound.nix ];

  # Needed for xwayland
  services.xserver.enable = true;
  # services.xserver.wacom.enable = true;
  # services.xserver.displayManager.gdm.enable = true;

  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "Hyprland";
        user = "aviinl";
      };
      default_session = initial_session;
    };
  };

  # c0d9dcc586ab17bf67c48c02a08bca28727f9237
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    portalPackage =
      inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
    xwayland.enable = true;
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";
  environment.sessionVariables.QT_QPA_PLATFORM = "wayland";
  environment.sessionVariables.QT_QPA_PLATFORMTHEME = "qt5ct";
  environment.sessionVariables.GTK_THEME = "Adwaita:dark";
}
