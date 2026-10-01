{ self, inputs, ... }: {

  flake.homeModules.zen-browser-config = { config, lib, pkgs, ...}: {

    imports = [
      inputs.zen-browser.homeModules.default
    ];

    options = {
      zen-browser-config.enable = lib.mkEnableOption "Zen Configuration";
    };

    config = lib.mkIf config.zen-browser-config.enable {
      
      home.sessionVariables.MOZ_LEGACY_PROFILES = "1";

      programs.zen-browser = {
        enable = true;
        setAsDefaultBrowser = true;
        policies = let
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
            "zen.window-sync.sync-only-pinned-tabs" = true;
            "zen.window-sync.enabled" = true;
            "zen.welcome-screen.seen" = true;
            "zen.show-newtab-button-top" = false;
          };
        };

        profiles.default = let 
            conIDPersonal = 1; 
            conIDShopping = 2;
            conIDBanking = 3;
            nixSnowflakeIcon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          in  {
          mods = [
            "2317fd93-c3ed-4f37-b55a-304c1816819e" # Audio Indicator Enhanced
            "f7c71d9a-bce2-420f-ae44-a64bd92975ab" # Better Unloaded Tabs 
            "ad97bb70-0066-4e42-9b5f-173a5e42c6fc" # Super Pins
            "d8b79d4a-6cba-4495-9ff6-d6d30b0e94fe" # Better Active Tab
            "c6813222-6571-4ba6-8faf-58f3343324f6" # Disable Rounded Corners
            "58649066-2b6f-4a5b-af6d-c3d21d16fc00" # Private Mode Hightlighting
            "03a8e7ef-cf00-4f41-bf24-a90deeafc9db" # Zen Color Picker
          ];

          search = {
            force = true;
            default = "ddg";
            privateDefault = "ddg";
            engines = {
              "Nix Packages" = {
                urls = [
                  {
                    template = "https://search.nixos.org/packages";
                    params = [
                      {
                        name = "type";
                        value = "packages";
                      }
                      {
                        name = "channel";
                        value = "unstable";
                      }
                      {
                        name = "query";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];
                icon = nixSnowflakeIcon;
                definedAliases = ["@pkgs"];
              };
              "Nix Options" = {
                urls = [
                  {
                    template = "https://search.nixos.org/options";
                    params = [
                      {
                        name = "channel";
                        value = "unstable";
                      }
                      {
                        name = "query";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];
                icon = nixSnowflakeIcon;
                definedAliases = ["@nop"];
              };
              "Home Manager Options" = {
                urls = [
                  {
                    template = "https://home-manager-options.extranix.com/";
                    params = [
                      {
                        name = "query";
                        value = "{searchTerms}";
                      }
                      {
                        name = "release";
                        value = "master"; # unstable
                      }
                    ];
                  }
                ];
                icon = nixSnowflakeIcon;
                definedAliases = ["hmop"];
              };

              "Google Maps" = {
                urls = [
                  {
                    template = "http://maps.google.com";
                    params = [
                      {
                        name = "q";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];
                definedAliases = ["@maps" "@gmaps"];
              };
              "StartPage" = {
                urls = [
                  {
                    template = "https://www.startpage.com/sp/search";
                    params = [
                      {
                        name = "q";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];
                definedAliases = ["@startpage" "@sp" "@pp"];
                icon = "https://www.startpage.com/sp/cdn/favicons/favicon-gradient.ico";
                updateInterval = 24 * 60 * 60 * 1000;
              };
              "ddg" = {
                urls = [
                  {
                    template = "https://duckduckgo.com";
                    params = [
                      {
                        name = "q";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];
                definedAliases = ["@duck" "@ddg" "@dck" "@dckk"];
              };

              bing.metaData.hidden = "true";
            };
          };

          settings = {
            "zen.urlbar.behavior" = "normal";
            "zen.urlbar.replace-newtab" = true;
            "zen.workspaces.continue-where-left-off" = true;
            "zen.view.show-clear-tabs-button" = true;
            "zen.view.use-single-toolbar" = false;
            "zen.view.sidebar-expanded" = true;
            "zen.view.sidebar-expanded.max-width" = 500;
            "zen.workspaces.show-workspace-indicator" = true;
            "permissions.default.loopback-network" = 2;
            "permissions.default.local-network" = 2;
            "media.videocontrols.picture-in-picture.enabled" = true;
            "zen.mediacontrols.enabled" = true;
            "browser.toolbars.bookmars.visibility" = true;
            "font.name.serif.x-western" = "JetBrainsMono Nerd Font";
            "zen.workspaces.separate-essentials" = false;
            "zen.workspaces.force-container-workspace" = true;
          };

          containersForce = true;
          containers = {
            Personal = {
              color = "yellow";
              icon = "chill";
              id = conIDPersonal;
            };
            Shopping = {
              color = "purple";
              icon = "cart";
              id = conIDShopping;
            };
            Banking = {
              color = "yellow";
              icon = "dollar";
              id = conIDBanking; 
            };

          };

          pinsForce = true;
          pinsForceAction = "demote";
          pins = {
            "Proton Mail" = {
              id = "280754c3-096e-4ac5-9144-401ae22a5e78";
              url = "https://mail.protonmail.com";
              position = 100;
              container = conIDPersonal;
              isEssential = true;
            };
            "Youtube" = {
              id = "901d0338-d473-46c0-a445-31d86da9c41f";
              url = "https://www.youtube.com";          
              position = 101;
              container = conIDPersonal;
              isEssential = true;
            };
          };

          spacesForce = true;

          spaces = let
            funColors = {
              opacity = 0.5;
              texture = 0.0;
              rotation = 45;
              type = "gradient";
              colors = [
                {
                  red = 38;
                  green = 217;
                  blue = 173;
                  algorithm = "floating";
                  type = "explicit-lightness";
                  lightness = 100;
                }
                {
                  red = 173;
                  green = 38;
                  blue = 217;
                  algorithm = "floating";
                  type = "explicit-lightness";
                  lightness = 100;
                }
                {
                  red = 217;
                  green = 173;
                  blue = 38;
                  algorithm = "floating";
                  type = "explicit-lightness";
                  lightness = 100;
                }
              ];
            };
            boringColors = {
              opacity = 0.5;
              texture = 0.0;
              rotation = 0;
              type = "gradient";
              colors = [
                {
                  red = 100;
                  green = 150;
                  blue = 100;
                  lightness = 100;
                }
              ];
            };
            
          in {

            "Computer" = {
              id = "99d4c387-f2eb-492b-a9f1-92f5cb5474d1";
              icon = "chrome://browser/skin/zen-icons/selectable/terminal.svg";
              position = 1000;
              container = conIDPersonal;
              theme = funColors;
              pins = {
                "Nix Stuff" = {
                  isGroup = true;
                  isFolderCollapsed = true;
                  folderIcon = "file://${nixSnowflakeIcon}";
                  id = "6721113f-1c22-4ec0-b0ae-2d2e1183de86";
                  pins = {
                    "Nixos Wiki" = {
                      id = "5d0bb7be-4441-490a-996b-305f1e449108";
                      url = "https://wiki.nixos.org/wiki/NixOS_Wiki";
                      position = 200;
                      container = conIDPersonal;
                    };
                    "Unofficial Nixos Wiki" = {
                      id = "42e15004-d0c1-4e25-99a3-059b3935390f";
                      url = "https://nixos.wiki/";
                      position = 201;
                      container = conIDPersonal;
                    };
                    "Nixos Packages Search" = {
                      id = "23486a45-f84a-446c-a908-e5aa3bb09adf";
                      url = "https://search.nixos.org/packages?channel=unstable";
                      position = 202;
                      container = conIDPersonal;
                    };
                    "Nixos Option Search" = {
                      id = "96a40b8a-41e0-4960-9b99-d66732652ec5";
                      url = "https://search.nixos.org/options?channel=unstable";
                      position = 203;
                      container = conIDPersonal;
                    };
                    "Home Manager Option Search" = {
                      id = "2d3c27fb-13c0-44b7-91cf-0ba540ee359c";
                      url = "https://home-manager-options.extranix.com/";
                      position = 204;
                      container = conIDPersonal;
                    };
                  };
                };
                
                "Cachy OS Wiki" = {
                  id = "03bbeceb-477e-4777-9754-aa8f31ae6f80";
                  url = "https://wiki.cachyos.org/";
                  position = 205;
                  container = conIDPersonal;
                };
                "Arch Wiki" = {
                  id = "a1adb71b-8a9d-462c-b6d2-f4d15a8ae6ee";
                  url = "https://wiki.archlinux.org/title/Main_page";
                  position = 206;
                  container = conIDPersonal;
                };
              };
            };

            "Gaming" = {
              id = "c739868a-8646-4706-8560-d26cd37dc1dc";
              icon = "chrome://browser/skin/zen-icons/selectable/game-controller.svg";
              position = 1001;
              container = conIDPersonal;
              theme = funColors;
              pins = {
                "ProtonDB" = {
                  id = "bde81d96-d86d-4ab7-93dd-7864dc977159";
                  url = "https://www.protondb.com/";
                  container = conIDPersonal;
                };
                "Nexus Mods" = {
                  id = "05c1971c-b275-4d58-9f31-ce4f74cd7b94";
                  url = "https://www.nexusmods.com/";
                  container = conIDPersonal;
                };
                "Thunder Store" = {
                  id = "edcc38d9-bb6c-4d11-a989-d9da080e6b7f";
                  url = "https://thunderstore.io/";
                  container = conIDPersonal;
                };
              };
            };

            "Personal" = {
              id = "4bbf583d-5e7b-4448-b5af-4744e397006e";
              icon = "chrome://browser/skin/zen-icons/selectable/chat.svg";
              position = 1002;
              container = conIDPersonal;
              theme = funColors;
            };

            "Shopping" = {
              id = "3cd730ad-0f1e-4f38-8cb0-b92c8ba2b8d7";
              icon = "chrome://browser/skin/zen-icons/selectable/basket.svg";
              position = 1003;
              container = conIDShopping;
              theme = boringColors;
              pins = {
                "Amazon" = {
                  id = "30f6da74-7bd9-4ff9-879b-ce52a3712730";
                  url = "https://www.amazon.com";
                  container = conIDShopping;
                };
                "Target" = {
                  id = "c573f96d-d2c1-4927-9ab9-88f9fa05cdb6";
                  url = "https://www.target.com";
                  container = conIDShopping;
                };
                "Walmart" = {
                  id = "3c58f5a7-42f3-4ce7-a9a1-6fbbbbc6e78e";
                  url = "https://www.walmart.com";
                  container = conIDShopping;
                };
                "eBay" = {
                  id = "a85d3843-f524-4720-890e-d68d58a3846a";
                  url = "https://www.ebay.com";
                  container = conIDShopping;
                };
              };
            };

            "School" = {
              id = "07373558-8ef4-488b-835d-43ad89b119c7";
              icon = "chrome://browser/skin/zen-icons/selectable/school.svg";
              position = 1004;
              container = conIDPersonal;
              theme = {
                opacity = 0.5;
                texture = 0.0;
                rotation = 45;
                type = "gradient";
                colors = [
                  {
                    red = 38;
                    green = 217;
                    blue = 173;
                    algorithm = "floating";
                    type = "explicit-lightness";
                    lightness = 100;
                  }
                  {
                    red = 173;
                    green = 38;
                    blue = 217;
                    algorithm = "floating";
                    type = "explicit-lightness";
                    lightness = 100;
                  }
                ];
              };
            };

            "Banking" = {
              id = "cee40526-19ae-4e61-8267-1f575413a41d";
              icon = "chrome://browser/skin/zen-icons/selectable/briefcase.svg";
              position = 1005;
              container = conIDBanking;
              theme = boringColors;
            };

          };
        
        };

      };

    };

  };

}