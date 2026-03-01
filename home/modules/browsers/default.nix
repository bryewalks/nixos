{ ... }:

let
  dracula = import ../themes/dracula.nix;
  vimiumCss = import ./vimium-css.nix dracula;

  webAppProfile = {
    isDefault = false;
    settings = {
      "browser.aboutwelcome.enabled" = false;
      "browser.startup.homepage_override.mstone" = "ignore";
      "browser.tabs.inTitlebar" = 0;
      "layout.css.prefers-color-scheme.content-override" = 2;
      "startup.homepage_welcome_url" = "";
      "startup.homepage_welcome_url.additional" = "";
      "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      "trailhead.firstrun.didSeeAboutWelcome" = true;
      "zen.sidebar.enabled" = false;
      "zen.view.compact" = true;
    };
    userContent = vimiumCss;
    userChrome = ''
      /* Hide all browser chrome for webapp appearance */
      #PersonalToolbar,
      #TabsToolbar,
      #nav-bar,
      #sidebar-box,
      #statuspanel,
      #titlebar,
      #zen-sidebar-box{
        visibility: collapse !important;
      }
    '';
  };
in
{
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = [ "zen-beta.desktop" ];
      "x-scheme-handler/http" = [ "zen-beta.desktop" ];
      "x-scheme-handler/https" = [ "zen-beta.desktop" ];
      "x-scheme-handler/about" = [ "zen-beta.desktop" ];
      "x-scheme-handler/unknown" = [ "zen-beta.desktop" ];
    };
  };

  programs.zen-browser = {
    enable = true;

    policies = {
      Homepage = {
        StartPage = "homepage";
        URL = "https://vimium.github.io";
      };
      ExtensionSettings = {
        "*".installation_mode = "allowed";
        "uBlock0@raymondhill.net" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
        };
        "{d7742d87-e61d-4b78-b8a1-b469842139fa}" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/vimium-ff/latest.xpi";
        };
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
        };
      };
      PasswordManagerEnabled = false;
    };

    profiles.default = {
      id = 0;
      isDefault = true;
      settings = {
        "browser.aboutwelcome.enabled" = false;
        "browser.startup.homepage_override.mstone" = "ignore";
        "layout.css.prefers-color-scheme.content-override" = 2;
        "startup.homepage_welcome_url" = "";
        "startup.homepage_welcome_url.additional" = "";
        "trailhead.firstrun.didSeeAboutWelcome" = true;
        "zen.window-sync.enabled" = true;
        "zen.window-sync.sync-only-pinned-tabs" = true;
      };
      userContent = vimiumCss;
      pinsForce = true;
      pins = {
        reddit = {
          id = "f695e0b6-d013-4915-9504-486702663425";
          url = "https://reddit.com";
          title = "Reddit";
          isEssential = true;
          position = 1;
        };
        lemmy = {
          id = "f33fe6a6-2920-490d-b5dd-3bf1fe94e9e3";
          url = "https://lemmy.ml";
          title = "Lemmy";
          isEssential = true;
          position = 2;
        };
        github = {
          id = "eb13638f-5c83-4f5b-84f9-eb168b396ebc";
          url = "https://github.com/bryewalks";
          title = "GitHub";
          isEssential = true;
          position = 3;
        };
      };
    };

    profiles.WebApp = webAppProfile // {
      id = 1;
    };
    profiles.WebApp-proton = webAppProfile // {
      id = 2;
    };
    profiles.WebApp-gmail = webAppProfile // {
      id = 3;
    };
    profiles.WebApp-claude = webAppProfile // {
      id = 4;
    };
  };

  stylix.targets.zen-browser.profileNames = [
    "default"
    "WebApp"
    "WebApp-claude"
    "WebApp-gmail"
    "WebApp-proton"
  ];
}
