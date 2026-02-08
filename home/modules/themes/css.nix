{ }:
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
    { cssPath, prefix ? "dracula", selector ? ":root" }:
    let
      palette = import ./dracula.nix;
      css = builtins.readFile cssPath;
    in
    {
      inherit palette;
      json = builtins.toJSON palette;
      css = resolvePaletteVars { inherit palette css prefix; };
    };
}
