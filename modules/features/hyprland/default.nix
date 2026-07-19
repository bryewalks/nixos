# _config/ holds the hyprland home configuration verbatim (underscored so
# import-tree leaves it alone). Per-host monitor/workspace layouts live in
# hosts/ as hyprland-<host> aspects included by each host.
{ den, inputs, ... }:

{
  # INFO: Hyprland is pinned to avoid plugins breaking on upstream updates.
  # Forks are kept at the last known working state for the pinned version.
  # When upgrading Hyprland, verify all plugins build/work before syncing forks.
  flake-file.inputs = {
    hyprland.url = "github:hyprwm/Hyprland/v0.55.4";

    hyprland-plugins = {
      # url = "github:hyprwm/hyprland-plugins";
      url = "github:bryewalks/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    hyprland-easymotion = {
      # url = "github:zakk4223/hyprland-easymotion";
      url = "github:bryewalks/hyprland-easymotion";
      inputs.hyprland.follows = "hyprland";
    };
  };

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
