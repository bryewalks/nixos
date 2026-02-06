{ pkgs, ... }:

{
  home.packages = with pkgs; [ flatpak ];

  services.flatpak = {
    remotes = [
      {
        name = "flathub";
        location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      }
    ];

    packages = [ "flathub:app/com.stremio.Stremio/x86_64/stable" ];
  };
}
