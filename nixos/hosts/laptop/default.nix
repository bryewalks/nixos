{
  networking.hostName = "laptop";

  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    options = [ "size=4G" "mode=755" ];
  };

  sops.defaultSopsFile = ./secrets.yaml;
}
