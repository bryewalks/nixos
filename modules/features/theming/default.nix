# Owns the theme pipeline: _themes/ holds the palette library (underscored so
# import-tree skips it). Each host picks its palette via the themeName
# capability (default dracula); this aspect builds the theme, exposes it as
# the home-manager `theme` option, and carries the stylix configuration.
# NOTE: icons (dracula-papirus below), cursors, and the sddm theme are still
# dracula-hardcoded — a non-dracula themeName changes palettes only.
{ den, inputs, lib, ... }:

let
  themeBuilder = import ./_themes/theme-builder.nix { inherit lib; };
in
{
  den.aspects.features.includes = [ den.aspects.theming ];

  den.aspects.theming =
    { host, ... }:
    let
      themeName = host.themeName or "dracula";
      theme = themeBuilder.mkTheme { theme = themeName; };

      stylix-config =
        { config, pkgs, ... }:
        let
          palette = theme.palette;
        in
        {
          stylix = {
            enable = true;
            autoEnable = false;
            polarity = "dark";
            fonts = {
              monospace = {
                package = pkgs.nerd-fonts.caskaydia-cove;
                name = "CaskaydiaCove Nerd Font Mono";
              };
              serif = config.stylix.fonts.monospace;
              sansSerif = config.stylix.fonts.monospace;
              emoji = config.stylix.fonts.monospace;
            };

            base16Scheme = {
              schema = "withHashTag";
              base00 = palette.background;
              base01 = palette.lightBackground;
              base02 = palette.selection;
              base03 = palette.currentLine;
              base04 = palette.darkForeground;
              base05 = palette.foreground;
              base06 = palette.lightForeGround;
              base07 = palette.brightWhite;
              base08 = palette.red;
              base09 = palette.orange;
              base0A = palette.yellow;
              base0B = palette.green;
              base0C = palette.cyan;
              base0D = palette.purple;
              base0E = palette.magenta;
              base0F = palette.brightRed;
            };

            icons = {
              enable = true;
              package = pkgs.dracula-papirus;
              dark = "Papirus-Dark";
              light = "Papirus";
            };

            targets.kitty.enable = true;
            targets.qt.enable = true;
            targets.gtk.enable = true;
            targets.kde.enable = true;
            targets.tmux.enable = true;
            targets.yazi.enable = true;
            targets.nixvim.enable = false;
            targets.zen-browser.enable = true;
          };

          # gtk.gtk4.theme = null;
        };
    in
    {
      provides.to-users.homeManager = {
        imports = [
          inputs.stylix.homeModules.stylix
          stylix-config
        ];

        options.theme = lib.mkOption {
          type = lib.types.submodule {
            freeformType = lib.types.attrsOf lib.types.raw;
            options = {
              name = lib.mkOption {
                type = lib.types.str;
                description = "Name of the active theme.";
              };
              palette = lib.mkOption {
                type = lib.types.attrsOf lib.types.str;
                description = "Hex colors (with leading #) keyed by role.";
              };
            };
          };
          description = ''
            Active theme produced by _themes/theme-builder: palette variants
            (hexNoHash, rgba, hexAlpha, ...) plus resolveCss for css templates.
          '';
        };

        config.theme = theme // {
          name = themeName;
          resolveCss = path: (themeBuilder.mkTheme { theme = themeName; cssPath = path; }).resolvedCss;
        };
      };
    };
}
