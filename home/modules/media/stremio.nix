{ pkgs, ... }:

{
  services.flatpak = {
    overrides.global.Context.filesystems = [
      "/nix/store:ro"
      "xdg-config/gtk-4.0:ro"
      "xdg-config/gtk-3.0:ro"
    ];

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
