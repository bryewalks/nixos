{
  networking.hostName = "laptop";

  swapfile = {
    enable = true;
    sizeGiB = 8;
  };

  # Needed for stremio
  services.flatpak.enable = true;

  sops.defaultSopsFile = ./secrets.yaml;
}
