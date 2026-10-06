# _config/ holds the hyprland home configuration verbatim (underscored so
# import-tree leaves it alone). Per-host monitor/workspace layouts live in
# hosts/ and register straight into each host's aspect.
{ den, inputs, ... }:

{
  # INFO: Hyprland is pinned to avoid plugins breaking on upstream updates.
  # Forks are kept at the last known working state for the pinned version.
  # When upgrading Hyprland, verify all plugins build/work before syncing forks.
  flake-file.inputs = {
    hyprland.url = "github:hyprwm/Hyprland/19fb395d45314960e6f79f17994a84094f1cd4f6";

    hyprland-plugins = {
      # url = "github:hyprwm/hyprland-plugins";
      url = "github:bryewalks/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    # BUG: no working version for 0.56 yet
    # hyprland-easymotion = {
    #   url = "github:bryewalks/hyprland-easymotion?ref=fix/hyprland-0.56";
    #   inputs.hyprland.follows = "hyprland";
    # };
  };

  den.aspects.workstation.includes = [ den.aspects.hyprland ];

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

        #BUG: Bug in xdg-desktop-portal where kvantum causes portal crash. temp override theme.
        # https://github.com/hyprwm/xdg-desktop-portal-hyprland/issues/414
        systemd.user.services.xdg-desktop-portal-hyprland.environment.QT_QPA_PLATFORMTHEME = "";
      };

    provides.to-users.homeManager = {
      imports = [
        inputs.hyprland.homeManagerModules.default
        ./_config
      ];
    };
  };
}
