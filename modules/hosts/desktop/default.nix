# _config/ holds this machine's hardware reality (plain NixOS modules + data;
# underscored so the flake-level import-tree leaves them alone — the initFilter
# here re-enables discovery inside it).
{ den, inputs, lib, ... }:

{
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
