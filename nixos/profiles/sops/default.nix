{ config, lib, ... }:

{
  sops = {
    age.keyFile = "/persist/sops/key.txt";
  };

  sops.secrets.ssh-key = {
    path = "/home/brye/.ssh/id_ed25519";
    owner = "brye";
    group = "users";
    mode = "0600";
  };
}
