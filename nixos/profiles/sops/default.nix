{ config, lib, ... }:

{
  sops = { age.keyFile = "/persist/system/var/lib/sops/keys.txt"; };

  sops.secrets.sshKey = {
    path = "/home/brye/.ssh/id_ed25519";
    owner = "brye";
    group = "users";
    mode = "0600";
  };

  sops.secrets.hashedPassword = {
    owner = "root";
    group = "root";
    mode = "0400";
    neededForUsers = true;
  };

  users.users.brye.hashedPasswordFile = config.sops.secrets.hashedPassword.path;

  systemd.tmpfiles.rules =
    [ "d /persist/system/var/lib/sops 0755 root root -" ];
}
