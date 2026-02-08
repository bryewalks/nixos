{ lib }:
let
  toRgba = { hex, opacity ? "ff" }:
    "rgba(${lib.strings.removePrefix "#" hex}${opacity})";
in
{
  inherit toRgba;
}
