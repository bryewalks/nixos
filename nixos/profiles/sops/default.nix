{ config, lib, ... }:

{
  sops = {
    age.keyFile = "/persist/system/var/lib/sops/keys.txt";
  };

  sops.secrets.ssh-key = {
    path = "/home/brye/.ssh/id_ed25519";
    owner = "brye";
    group = "users";
    mode = "0600";
  };
}
