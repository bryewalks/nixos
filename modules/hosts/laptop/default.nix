# _config/ holds this machine's hardware reality (plain NixOS modules + data;
# underscored so the flake-level import-tree leaves them alone — the initFilter
# here re-enables discovery inside it).
{ den, inputs, lib, ... }:

{
  den.hosts.x86_64-linux.laptop = {
    users.brye = { };
    # Capability: palette consumed by modules/features/theming.
    themeName = "dracula";
  };

  flake.diskoConfigurations.laptop = import ./_config/disko.nix;

  den.aspects.laptop = {
    includes = [
      den.aspects.base
      den.aspects.features
      den.aspects.plymouth
      den.aspects.hyprland-laptop
    ];
    nixos.imports = [
      (inputs.import-tree.initFilter (lib.hasSuffix ".nix") ./_config)
    ];
  };
}
