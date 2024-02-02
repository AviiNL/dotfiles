{ config, pkgs, ... }: {

  # Set librewolf as default browser
  home.sessionVariables = { BROWSER = "librewolf"; };
  #   xdg.mimeApps.defaultApplications = {
  #     "x-scheme-handler/http" = desktop;
  #     "x-scheme-handler/https" = desktop;
  #   };
  # pkgs.librewolf.path

  programs.librewolf = {
    enable = true;
    # Enable WebGL, cookies and history
    settings = {
      "webgl.disabled" = false;
      "privacy.resistFingerprinting" = false;
      "privacy.clearOnShutdown.history" = false;
      "privacy.clearOnShutdown.cookies" = false;
      "network.cookie.lifetimePolicy" = 0;
    };
  };
}
