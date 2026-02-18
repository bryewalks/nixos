{ lib, pkgs, ... }:
let
  xcursorDracula = import ../../../../../nixos/pkgs/dracula-cursors.nix { inherit pkgs; };
  hyprcursorDracula = pkgs.stdenvNoCC.mkDerivation {
    pname = "hyprcursor-dracula-kde";
    version = "git";
    src = pkgs.fetchFromGitHub {
      owner = "guillaumeboehm";
      repo = "hyprcursor_dracula_kde";
      rev = "ede217548cb6ee45ac71d714dd23d18e5a927b9b";
      hash = "sha256-rBi2Ji9aoy4evATTRLu3m8GvIuHcqXRBtehA/eAdaW0=";
    };
    nativeBuildInputs = [ pkgs.hyprcursor ];
    buildPhase = ''
      hyprcursor-util --create . -o .
    '';
    installPhase = ''
      mkdir -p $out/share/icons
      cp -r theme_Dracula $out/share/icons/hyprcursor_Dracula
    '';
  };
in
{
  home.packages = [ pkgs.hyprcursor ];

  xdg.dataFile."icons/hyprcursor_Dracula".source =
    "${hyprcursorDracula}/share/icons/hyprcursor_Dracula";

  home.pointerCursor = {
    name = "Dracula-cursors";
    package = xcursorDracula;
    size = 24;
    x11.enable = true;
    gtk.enable = true;
  };

  wayland.windowManager.hyprland.settings = {
    env = [
      "HYPRCURSOR_SIZE,24"
      "HYPRCURSOR_THEME,hyprcursor_Dracula"
      "WLR_NO_HARDWARE_CURSORS,1"
    ];
  };
}
