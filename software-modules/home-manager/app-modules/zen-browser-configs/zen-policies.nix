{ ... }: {

  flake.homeModules.zen-policies =
  let
    mkLockedAttrs = builtins.mapAttrs (_: value: {
      Value = value;
      Status = "locked";
    });

    mkPluginUrl = id: "https://addons.mozilla.org/firefox/downloads/latest/${id}/latest.xpi";

    mkExtensionEntry = {
      id,
      pinned ? false,
    }: let
      base = {
        install_url = mkPluginUrl id;
        installation_mode = "force_installed";
      };
    in
      if pinned
      then base // {default_area = "navbar";}
      else base;

    mkExtensionSettings = builtins.mapAttrs (_: entry:
      if builtins.isAttrs entry
      then entry
      else mkExtensionEntry {id = entry;});

  in {
    AutofillAddressEnabled = false;
    AutofillCreditCardEnabled = false;
    DisableAppUpdate = true;
    DisableFeedbackCommands = false;
    DisableFirefoxStudies = true;
    DisablePocket = true;
    DisableTelemetry = true;
    DisableProfileImport = true;
    DontCheckDefaultBrowser = true;
    NoDefaultBookmarks = true;
    OfferToSaveLogins = false;
    EnableTrackingProtection = {
      Value = true;
      Locked = false;
      Cryptomining = true;
      Fingerprinting = true;
    };

    SanitizeOnShutdown = {
      FormData = true;
      Cache = true;
    };

    ExtensionSettings = mkExtensionSettings {
      "uBlock0@raymondhill.net" = mkExtensionEntry {
        id = "ublock-origin";
        pinned = true;
      }; # Ublock Origin

      "78272b6fa58f4a1abaac99321d503a20@proton.me" = mkExtensionEntry {
        id = "proton-pass";
        pinned = true;
      }; # Proton Pass: Pasword manager

      "sponsorBlocker@ajay.app" = "sponsorblock"; # Sponser Block
      "id1-MnnxcxisBPnSXQ@jetpack" = "privacy-badger17"; # Privacy Badger
      "firefox@betterttv.net" = "betterttv"; # Better TTV
      "@searchengineadremover" = "searchengineadremover"; # Search Engine Ad Remover
      "firefox-extension@steamdb.info" = "steam-database";
      "github-no-more@ihatereality.space" = "github-no-more";
      "github-repository-size@pranavmangal" = "gh-repo-size";
      "jid1-BoFifL9Vbdl2zQ@jetpack" = "decentraleyes";
      "remove.youtube.tracking@moreo.app" = "remove-youtube-tracking";
      "{a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad}" = "refined-github-"; # Refined GitHub
      "{cb31ec5d-c49a-4e5a-b240-16c767444f62}" = "indie-wiki-buddy"; # Indie Wiki Buddy
      "{74145f27-f039-47ce-a470-a662b129930a}" = "clearurls"; # Clear URLs
      "{85860b32-02a8-431a-b2b1-40fbd64c9c69}" = "github-file-icons"; # File Icon for Gihub, gitlab and bitbucket

    };

    "3rdparty".Extensions."uBlock0@raymondhill.net".toOverwrite = {
      filterLists = [
        "user-filters"
        "ublock-filters"
        "ublock-badware"
        "ublock-privacy"
        "ublock-quick-fixes"
        "ublock-unbreak"
      ];
      filters = ["||doubleclick.net^"];
    };

    Preferences = mkLockedAttrs {
      "browser.aboutConfig.showWarning" = false;
      "browser.gesture.swipe.left" = "";
      "browser.gesture.swipe.right" = "";
      "browser.newtabpage.activity-stream.feeds.topsites" = false;
      "browser.startup.homepage" = "about:home";
      "browser.tabs.warnOnClose" = "true";
      "browser.topsites.contile.enabled" = false;
      "browser.translations.enable" = false;
    };

  };
}
