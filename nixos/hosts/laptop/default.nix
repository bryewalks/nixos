{
  networking.hostName = "laptop";

  swapfile = {
    enable = true;
    sizeGiB = 8;
  };

  mySystem.isPasswordConfigured = true;
  sops.defaultSopsFile = ./secrets.yaml;
}
