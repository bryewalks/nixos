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
in
{
  inherit mkVarBlock replacePaletteLiterals;

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
}
