{
  networking.hostName = "laptop";

  # Needed for stremio
  services.flatpak.enable = true;

  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    options = [ "size=4G" "mode=755" ];
  };

  sops.defaultSopsFile = ./secrets.yaml;
}
