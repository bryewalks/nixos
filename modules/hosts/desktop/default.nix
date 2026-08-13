# _config/ holds this machine's hardware reality (plain NixOS modules + data;
# underscored so the flake-level import-tree leaves them alone — the initFilter
# here re-enables discovery inside it).
{
  den,
  inputs,
  lib,
  ...
}:

{
  den.hosts.x86_64-linux.desktop = {
    users.brye = { };
    passwordConfigured = true;
    persistRoot = "/persist";
    storageRoot = "/mnt/storage";
    backupRoot = "/mnt/backups";
    swapSizeGiB = 36;
    themeName = "dracula";
  };

  flake.diskoConfigurations.desktop = import ./_config/disko.nix;

  den.aspects.desktop = {
    includes = [
      den.aspects.workstation
      den.aspects.cachyos-kernel
      den.aspects.backups
      den.aspects.backups-dropbox
    ];
    nixos.imports = [
      (inputs.import-tree.initFilter (lib.hasSuffix ".nix") ./_config)
    ];
  };
}
