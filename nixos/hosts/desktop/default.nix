{
  networking.hostName = "desktop";

  # Needed for stremio
  services.flatpak.enable = true;

  sops.defaultSopsFile = ./secrets.yaml;
}
