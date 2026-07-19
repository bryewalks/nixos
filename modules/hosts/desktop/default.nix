# _config/ holds this machine's hardware reality (plain NixOS modules + data;
# underscored so the flake-level import-tree leaves them alone — the initFilter
# here re-enables discovery inside it).
{ den, inputs, lib, ... }:

{
  den.hosts.x86_64-linux.desktop = {
    users.brye = { };
    # Capability: media directories live on the storage array.
    # Consumed by modules/features/directories.
    storageRoot = "/mnt/storage";
    # Capability: palette consumed by modules/features/theming.
    themeName = "dracula";
  };

  flake.diskoConfigurations.desktop = import ./_config/disko.nix;

  den.aspects.desktop = {
    includes = [
      den.aspects.base
      den.aspects.features
      den.aspects.hyprland-desktop
    ];
    nixos.imports = [
      (inputs.import-tree.initFilter (lib.hasSuffix ".nix") ./_config)
    ];
  };
}
