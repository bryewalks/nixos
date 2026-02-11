{ config, pkgs, ... }:

{
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = [ "firefox.desktop" ];
      "x-scheme-handler/http" = [ "firefox.desktop" ];
      "x-scheme-handler/https" = [ "firefox.desktop" ];
      "x-scheme-handler/about" = [ "firefox.desktop" ];
      "x-scheme-handler/unknown" = [ "firefox.desktop" ];
    };
  };

  programs.chromium = {
    enable = true;
    extensions = [
      { id = "nngceckbapebfimnlniiiahkandclblb"; } # Bitwarden
      { id = "ddkjiahejlhfcafbddmgiahcphecmpfh"; } # uBlock Origin
      { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; } # Vimium
    ];
    dictionaries = [ pkgs.hunspellDictsChromium.en_US ];
  };

  home.file."${config.xdg.configHome}/chromium/Policies/Managed/managed_policies.json".text =
    builtins.toJSON {
      HomepageLocation = "https://vimium.github.io";
      HomepageIsNewTabPage = false;
      RestoreOnStartup = 4;
      RestoreOnStartupURLs = [ "https://vimium.github.io" ];
      ExtensionSettings = {
        "*".installation_mode = "allowed";
        "nngceckbapebfimnlniiiahkandclblb" = {
          installation_mode = "force_installed";
          update_url = "https://clients2.google.com/service/update2/crx";
        };
        "ddkjiahejlhfcafbddmgiahcphecmpfh" = {
          installation_mode = "force_installed";
          update_url = "https://clients2.google.com/service/update2/crx";
        };
        "dbepggeogbaibhgnhhndojpepiihcmeb" = {
          installation_mode = "force_installed";
          update_url = "https://clients2.google.com/service/update2/crx";
        };
      };
      ExtensionInstallForcelist = [
        "nngceckbapebfimnlniiiahkandclblb;https://clients2.google.com/service/update2/crx"
        "ddkjiahejlhfcafbddmgiahcphecmpfh;https://clients2.google.com/service/update2/crx"
        "dbepggeogbaibhgnhhndojpepiihcmeb;https://clients2.google.com/service/update2/crx"
      ];
      PasswordManagerEnabled = false;
      CredentialsEnableService = false;
    };

  programs.firefox = {
    enable = true;
    package = pkgs.firefox;

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
  };
}
