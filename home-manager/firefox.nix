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
  # nixpkgs.config.allowUnfree = true;
  # nixpkgs.config.allowUnfreePredicate = pkg:
  #   builtins.elem (lib.getName pkg) [
  #     "betterttv-7.5.15"
  #     "enhancer-for-youtube-2.0.121"
  #   ];

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
        "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts" =
          {
            "Value" = false;
            "Status" = "locked";
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

# Enhancer for youtube settings, need to find a way to embed this
# {"version":"2.0.122","settings":{"blur":0,"brightness":100,"contrast":100,"grayscale":0,"huerotate":0,"invert":0,"saturate":100,"sepia":0,"applyvideofilters":false,"backgroundcolor":"#000000","backgroundopacity":85,"blackbars":false,"blockautoplay":true,"blockhfrformats":false,"blockwebmformats":false,"boostvolume":false,"cinemamode":false,"cinemamodewideplayer":true,"controlbar":{"active":false,"autohide":false,"centered":true,"position":"absolute"},"controls":["cards-end-screens"],"controlsvisible":true,"controlspeed":true,"controlspeedmousebutton":false,"controlvolume":true,"controlvolumemousebutton":false,"convertshorts":true,"customcolors":{"--main-color":"#00adee","--main-background":"#111111","--second-background":"#181818","--hover-background":"#232323","--main-text":"#eff0f1","--dimmer-text":"#cccccc","--shadow":"#000000"},"customcssrules":"","customscript":"","customtheme":false,"darktheme":false,"date":0,"defaultvolume":false,"disableautoplay":true,"executescript":false,"expanddescription":false,"filter":"none","hidecardsendscreens":false,"hidechat":false,"hidecomments":false,"hiderelated":false,"hideshorts":false,"ignoreplaylists":true,"ignorepopupplayer":true,"localecode":"en_US","localedir":"ltr","message":false,"miniplayer":true,"miniplayerposition":"_top-left","miniplayersize":"_400x225","newestcomments":false,"overridespeeds":false,"pauseforegroundtab":false,"pausevideos":true,"popuplayersize":"640x360","qualityembeds":"medium","qualityembedsfullscreen":"hd1080","qualityplaylists":"hd720","qualityplaylistsfullscreen":"hd1080","qualityvideos":"hd720","qualityvideosfullscreen":"hd1080","reload":false,"reversemousewheeldirection":false,"selectquality":false,"selectqualityfullscreenoff":false,"selectqualityfullscreenon":false,"speed":1,"speedvariation":0.1,"stopvideos":false,"theatermode":false,"theme":"default-dark","themevariant":"youtube-deep-dark.css","update":0,"volume":50,"volumemultiplier":3,"volumevariation":5,"wideplayer":false,"wideplayerviewport":false}}
