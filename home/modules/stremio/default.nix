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

    packages = [
      {
        appId = "com.stremio.Stremio";
        origin = "flathub";
      }
    ];
  };
}
