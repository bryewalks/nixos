{
  networking.hostName = "laptop";

  # Needed for stremio
  services.flatpak.enable = true;

  sops.defaultSopsFile = ./secrets.yaml;
}
