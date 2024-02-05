{ inputs, outputs, lib, config, pkgs, ... }: {

  programs.browserpass.enable = true;
  programs.firefox = {
    enable = true;
    profiles.aviinl = {
      extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
        ublock-origin
        browserpass
      ];
      search = {
        default = "DuckDuckGo";
        privateDefault = "DuckDuckGo";
        force = true;
      };
      settings = {
        "app.normandy.first_run" = false;
        "browser.disableResetPrompt" = true;
        "browser.download.panel.shown" = false;
        "browser.download.useDownloadDir" = true;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts.havePinned" =
          "";
        "browser.newtabpage.pinned" = "[]";
        "browser.shell.checkDefaultBrowser" = false;
        "browser.shell.defaultBrowserCheckCount" = 1;
        "browser.uiCustomization.state" = ''
          {"placements":{"widget-overflow-fixed-list":[],"nav-bar":["back-button","forward-button","stop-reload-button","home-button","urlbar-container","downloads-button","library-button","ublock0_raymondhill_net-browser-action","_testpilot-containers-browser-action"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["tabbrowser-tabs","new-tab-button","alltabs-button"],"PersonalToolbar":["personal-bookmarks"]},"seen":["save-to-pocket-button","developer-button","ublock0_raymondhill_net-browser-action","_testpilot-containers-browser-action"],"dirtyAreaCache":["nav-bar","PersonalToolbar","toolbar-menubar","TabsToolbar","widget-overflow-fixed-list"],"currentVersion":18,"newElementCount":4}'';
        "dom.security.https_only_mode" = true;
        "identity.fxaccounts.enabled" = true;
        "privacy.trackingprotection.enabled" = true;
        "signon.rememberSignons" = true;
        "services.sync.prefs.sync.browser.newtabpage.pinned" = false;
      };
    };
  };

}
