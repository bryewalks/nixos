{ ... }:

{
  den.hosts.x86_64-linux.laptop.users.brye = { };
  den.hosts.x86_64-linux.desktop = {
    users.brye = { };
    # Capability: media directories live on the storage array.
    # Consumed by modules/features/directories.
    storageRoot = "/mnt/storage";
  };

  flake.diskoConfigurations.laptop = import ./laptop/_config/disko.nix;
  flake.diskoConfigurations.desktop = import ./desktop/_config/disko.nix;
}
