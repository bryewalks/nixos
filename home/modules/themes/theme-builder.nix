{ lib ? null }:
let
  # Theme helpers:
  # - resolve CSS vars (var(--theme-name)) using a palette
  # - build theme-derived outputs for CSS and Hyprland consumers
  varNames = palette: builtins.attrNames palette;

  resolvePaletteVars = { palette, css, theme }:
    assert builtins.isAttrs palette;
    assert builtins.isString css;
    assert builtins.isString theme;
    assert theme != "";
    let
      names = varNames palette;
      from = map (name: "var(--${theme}-${name})") names;
      to = map (name: palette.${name}) names;
    in
    builtins.replaceStrings from to css;
in
rec {
  inherit resolvePaletteVars;

  mkTheme =
    {
      theme,
      cssPath ? null,
    }:
    assert builtins.isString theme;
    assert theme != "";
    assert cssPath == null || builtins.pathExists cssPath;
    let
      themePath = ./. + "/${theme}.nix";
      _ = assert builtins.pathExists themePath; true;
      palette = import themePath;
      css = if cssPath == null then "" else builtins.readFile cssPath;
      stripHash = hex: builtins.replaceStrings [ "#" ] [ "" ] hex;
      withAlpha = hex: opacity: "#${stripHash hex}${opacity}";
      toRgba =
        {
          hex,
          opacity ? "ff",
        }:
        "rgba(${stripHash hex}${opacity})";
      hexAlpha = builtins.mapAttrs (_: hex: withAlpha hex "ff") palette;
      baseTheme = {
        inherit palette;
        json = builtins.toJSON palette;
        resolvedCss = resolvePaletteVars {
          inherit palette css;
          inherit theme;
        };
        inherit hexAlpha;
        hexNoHash = builtins.mapAttrs (_: hex: stripHash hex) palette;
        hexAlphaNoHash = builtins.mapAttrs (_: hex: stripHash hex) hexAlpha;
        inherit withAlpha;
      };
      rgbaTheme =
        if lib == null then
          {
            rgba = null;
            withRgbaAlpha = null;
          }
        else
          {
            rgba = builtins.mapAttrs (_: hex: toRgba { inherit hex; }) palette;
            withRgbaAlpha = hex: opacity: toRgba { inherit hex opacity; };
          };
    in
    baseTheme // rgbaTheme;
}
