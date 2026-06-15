{
  networking.hostName = "laptop";

  swapfile = {
    enable = true;
    sizeGiB = 8;
  };

  # Needed for stremio
  services.flatpak.enable = true;

  mySystem.passwordConfigured = true;
  sops.defaultSopsFile = ./secrets.yaml;
}
