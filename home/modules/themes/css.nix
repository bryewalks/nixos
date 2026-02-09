{ lib ? null }:
let
  varNames = palette: builtins.attrNames palette;

  mkVarBlock = { palette, prefix ? "theme", selector ? ":root" }:
    let
      names = varNames palette;
      lines = map (name: "  --${prefix}-${name}: ${palette.${name}};") names;
    in
    ''
      ${selector} {
      ${builtins.concatStringsSep "\n" lines}
      }
    '';

  replacePaletteLiterals = { palette, css, prefix ? "theme" }:
    let
      names = varNames palette;
      from = map (name: palette.${name}) names;
      to = map (name: "var(--${prefix}-${name})") names;
    in
    builtins.replaceStrings from to css;

  resolvePaletteVars = { palette, css, prefix ? "theme" }:
    let
      names = varNames palette;
      from = map (name: "var(--${prefix}-${name})") names;
      to = map (name: palette.${name}) names;
    in
    builtins.replaceStrings from to css;
in
rec {
  inherit mkVarBlock replacePaletteLiterals resolvePaletteVars;

  themedCss =
    {
      palette,
      css,
      prefix ? "theme",
      selector ? ":root",
    }:
    mkVarBlock { inherit palette prefix selector; }
    + "\n"
    + replacePaletteLiterals { inherit palette css prefix; };

  mkDraculaTheme =
    { cssPath ? null, prefix ? "dracula", selector ? ":root" }:
    let
      palette = import ./dracula.nix;
      css = if cssPath == null then "" else builtins.readFile cssPath;
      stripHash = hex: builtins.replaceStrings [ "#" ] [ "" ] hex;
      withAlpha = hex: opacity: "#${stripHash hex}${opacity}";
      themeUtils = if lib == null then null else import ./utils.nix { inherit lib; };
      withRgbaAlpha =
        if themeUtils == null then
          null
        else
          (hex: opacity: themeUtils.toRgba { inherit hex opacity; });
      rgba =
        if themeUtils == null then
          null
        else
          builtins.mapAttrs (_: hex: themeUtils.toRgba { inherit hex; }) palette;
    in
    {
      inherit palette;
      json = builtins.toJSON palette;
      css = resolvePaletteVars { inherit palette css prefix; };
      hexAlpha = builtins.mapAttrs (_: hex: withAlpha hex "ff") palette;
      hexAlphaNoHash = builtins.mapAttrs (_: hex: stripHash hex) (builtins.mapAttrs (_: hex: withAlpha hex "ff") palette);
      inherit rgba;
      inherit withAlpha;
      inherit withRgbaAlpha;
    };
}
