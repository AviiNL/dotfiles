{ pkgs, ... }: {
  xdg.mimeApps.defaultApplications = {
    # Web
    "text/html" = [ "firefox.desktop" ];
    "text/xml" = [ "firefox.desktop" ];
    "x-scheme-handler/http" = [ "firefox.desktop" ];
    "x-scheme-handler/https" = [ "firefox.desktop" ];

    # Images
    "image/png" = [ "swappy.desktop" ];
    "image/jpeg" = [ "swappy.desktop" ];
  };
}
