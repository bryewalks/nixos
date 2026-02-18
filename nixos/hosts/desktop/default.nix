{
  networking.hostName = "desktop";

  disabledModules = [ ../../modules/plymouth/default.nix ];

  # Needed for stremio
  services.flatpak.enable = true;

  sops.defaultSopsFile = ./secrets.yaml;
}
