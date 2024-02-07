{ inputs, outputs, lib, config, pkgs, ... }: {

  /* [x] betterttv
     [x] browserpass
     [ ] DocsAfterDark
     [x] enhancer-for-youtube
     [ ] Minecraft wiki redirector
     [x] return-youtube-dislikes
     [x] sponsorblock
     [x] stylus
     [x] ublock-origin
     [ ] video scrubber for instagram
     [ ] youtube volume scroll
  */

  # this shit doesnt work.. still cant install bttv, nor enhancer-for-youtube
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "betterttv-7.5.15"
      "enhancer-for-youtube-2.0.121"
    ];

  programs.browserpass.enable = true;
  programs.firefox = {
    enable = true;

    policies = {
      "SearchEngines" = [{
        "Default" = "DuckDuckGo";
        "Remove" = [ "Amazon.com" "Bing" "eBay" "Wikipedia (en)" ];
      }];
      "EnableTrackingProtection" = {
        "Value" = true;
        "Cryptomining" = true;
        "Fingerprinting" = true;
        "Locked" = false;
      };
      "FirefoxHome" = {
        "SponsoredTopSites" = false;
        "SponsoredPocket" = false;
        "Locked" = false;
      };
      "Preferences" = {
        "dom.security.https_only_mode" = {
          "Value" = true;
          "Status" = "default";
        };
        "browser.newtabpage.pinned" = {
          "Value" = "";
          "Status" = "default";
        };
      };
      "DisablePocket" = true;
      "DisableTelemetry" = true;
      "DisableFirefoxStudies" = true;
      "DontCheckDefaultBrowser" = "true";
    };
    profiles.aviinl = {
      extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
        # betterttv
        browserpass
        # enhancer-for-youtube
        return-youtube-dislikes
        sponsorblock
        stylus
        ublock-origin
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
        "browser.newtabpage.pinned" = "";
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
