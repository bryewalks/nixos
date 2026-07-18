# _config/ holds the hyprland home configuration verbatim (underscored so
# import-tree leaves it alone). Per-host monitor/workspace layouts live in
# hosts/ as hyprland-<host> aspects included by each host.
{ den, inputs, ... }:

{
  den.aspects.features.includes = [ den.aspects.hyprland ];

  den.aspects.hyprland = {
    nixos =
      { pkgs, ... }:
      {
        imports = [ inputs.hyprland.nixosModules.default ];

        programs.hyprland = {
          enable = true;
          xwayland.enable = true;
        };

        xdg.portal = {
          enable = true;
          extraPortals = [
            pkgs.xdg-desktop-portal-gtk
          ];
        };
      };

    provides.to-users.homeManager = {
      imports = [
        inputs.hyprland.homeManagerModules.default
        ./_config
      ];
    };
  };
}
