{
  networking.hostName = "laptop";

  swapfile = {
    enable = true;
    sizeGiB = 8;
  };

  # Needed for stremio
  services.flatpak.enable = true;

  mySystem.isPasswordConfigured = true;
  sops.defaultSopsFile = ./secrets.yaml;
}
