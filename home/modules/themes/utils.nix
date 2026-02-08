{ lib }:
let
  toRgba =
    {
      hex,
      opacity ? "ff",
    }:
    "rgba(${lib.strings.removePrefix "#" hex}${opacity})";
  hexDigit =
    c:
    {
      "0" = 0;
      "1" = 1;
      "2" = 2;
      "3" = 3;
      "4" = 4;
      "5" = 5;
      "6" = 6;
      "7" = 7;
      "8" = 8;
      "9" = 9;
      "a" = 10;
      "b" = 11;
      "c" = 12;
      "d" = 13;
      "e" = 14;
      "f" = 15;
    }
    .${c};
  hexByte =
    s:
    let
      chars = lib.strings.stringToCharacters (lib.strings.toLower s);
      hi = hexDigit (builtins.elemAt chars 0);
      lo = hexDigit (builtins.elemAt chars 1);
    in
    hi * 16 + lo;
  toCssRgba =
    {
      hex,
      opacity ? "ff",
    }:
    let
      clean = lib.strings.removePrefix "#" hex;
      r = hexByte (builtins.substring 0 2 clean);
      g = hexByte (builtins.substring 2 2 clean);
      b = hexByte (builtins.substring 4 2 clean);
      a = (hexByte opacity) / 255.0;
    in
    "rgba(${toString r}, ${toString g}, ${toString b}, ${toString a})";
in
{
  inherit toRgba toCssRgba;
}
