{
  sops.defaultSopsFile = ./secrets.yaml;

  # Release this machine was installed under — never bump on upgrades.
  system.stateVersion = "25.11";
}
