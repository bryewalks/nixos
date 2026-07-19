{ pkgs, lib, color ? "dracula-purple" }:

let
  dracula-papirus-src = pkgs.fetchFromGitHub {
    owner = "dracula";
    repo = "papirus-folders";
    rev = "master";
    hash = "sha256-P9Wf+RVShIJ9QtVzoudEglTqAPwl8cisnpdu0Mn61H8=";
  };
in
pkgs.stdenvNoCC.mkDerivation {
  pname = "papirus-icon-theme-dracula";
  version = "git";

  buildCommand = ''
    mkdir -p $out/share/icons

    # Copy base papirus theme (dereference symlinks so dracula icons can overlay)
    cp -rL ${pkgs.papirus-icon-theme}/share/icons/. $out/share/icons/
    chmod -R +w $out/share/icons

    # Add Dracula folder icons to all Papirus variants
    for variant in Papirus Papirus-Dark Papirus-Light; do
      if [ -d "$out/share/icons/$variant" ]; then
        cp -r ${dracula-papirus-src}/Icons/* $out/share/icons/$variant/
      fi
    done

    # Create symlinks from standard names to the selected Dracula color
    # e.g. folder-${color}.svg -> folder.svg
    find $out/share/icons -name "*-${color}*.svg" | while read f; do
      dir=$(dirname "$f")
      base=$(basename "$f")
      target="$dir/$(echo "$base" | sed 's/-${color}//')"
      ln -sf "$base" "$target"
    done
  '';
}
