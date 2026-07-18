# Per-host hyprland layouts (monitors, workspace routing, wallpaper targets).
# Each host aspect includes its own; content stays as plain HM modules in the
# underscored dirs.
{ den, ... }:

{
  den.aspects.hyprland-laptop.provides.to-users.homeManager = {
    imports = [
      ./_laptop/default.nix
      ./_laptop/hyprpaper.nix
    ];
  };

  den.aspects.hyprland-desktop.provides.to-users.homeManager = {
    imports = [
      ./_desktop/default.nix
      ./_desktop/hyprpaper.nix
    ];
  };
}
