# Per-host hyprland layouts (monitors, workspace routing, wallpaper targets).
# Registered straight into each host's aspect; content stays as plain HM
# modules in the underscored dirs.
{ ... }:

{
  den.aspects.laptop.provides.to-users.homeManager.imports = [
    ./_laptop/default.nix
    ./_laptop/hyprpaper.nix
  ];

  den.aspects.desktop.provides.to-users.homeManager.imports = [
    ./_desktop/default.nix
    ./_desktop/hyprpaper.nix
  ];
}
