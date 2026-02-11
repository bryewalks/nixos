{ pkgs, ... }:

{
  programs.chromium = {
    enable = true;
    extensions = [
      { id = "nngceckbapebfimnlniiiahkandclblb"; } # Bitwarden
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # uBlock Origin
      { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; } # Vimium
    ];
    dictionaries = [ pkgs.hunspellDictsChromium.en_US ];
  };

  programs.firefox = {
    enable = true;
    package = pkgs.firefox;

    profiles.default = {
      extensions.packages = with pkgs.firefox-addons; [
        bitwarden
        ublock-origin
        vimium
      ];
    };
  };
}
