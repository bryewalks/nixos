{ pkgs }:
pkgs.stdenvNoCC.mkDerivation {
  pname = "dracula-cursors";
  version = "git";
  src = pkgs.fetchFromGitHub {
    owner = "dracula";
    repo = "gtk";
    rev = "1282a6806d568b736fddf783263fc96ccd34a8ce";
    hash = "sha256-6fYbe3CVfCw/CZaFX5Mc1DPb4+uiQLIZlirx+2/jUzw=";
  };
  installPhase = ''
    mkdir -p $out/share/icons
    cp -r kde/cursors/Dracula-cursors $out/share/icons/Dracula-cursors
  '';
}
