{ config, hyprHostName, lib, pkgs, ... }:
let
  hostDir = ../../hosts + "/${hyprHostName}";
  hostHyprpaper = hostDir + "/hyprpaper.nix";
  themeBuilder = import ../../../themes/theme-builder.nix { };
  draculaTheme = themeBuilder.mkTheme { theme = "dracula"; };
in
{
  home.packages = [
    pkgs.hyprpaper
    pkgs.waypaper
  ];

  imports = lib.optional (builtins.pathExists hostHyprpaper) hostHyprpaper;

  xdg.dataFile."wallpapers" = {
    source = ../../../../assets/wallpapers;
    recursive = true;
  };

  xdg.configFile."waypaper/config.ini.template".text = ''
    [Settings]
    language = en
    folder = ${config.xdg.dataHome}/wallpapers
    monitors = All
    wallpaper = ${config.xdg.dataHome}/wallpapers/shaded-landscape.png
    show_path_in_tooltip = True
    backend = hyprpaper
    fill = fill
    sort = name
    color = ${draculaTheme.palette.white}
    subfolders = False
    all_subfolders = False
    show_hidden = False
    show_gifs_only = False
    zen_mode = False
    post_command =
    number_of_columns = 3
    swww_transition_type = any
    swww_transition_step = 90
    swww_transition_angle = 0
    swww_transition_duration = 2
    swww_transition_fps = 60
    mpvpaper_sound = False
    mpvpaper_options =
    use_xdg_state = False
    stylesheet = ${config.xdg.configHome}/waypaper/style.css
    keybindings = ${config.xdg.configHome}/waypaper/keybindings.ini
  '';

  home.activation.waypaperSeedConfig =
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      cfg="${config.xdg.configHome}/waypaper/config.ini"
      tmpl="${config.xdg.configHome}/waypaper/config.ini.template"

      if [ -L "$cfg" ]; then
        rm -f "$cfg"
      fi

      if [ ! -e "$cfg" ]; then
        mkdir -p "$(dirname "$cfg")"
        cp "$tmpl" "$cfg"
      fi

      chmod u+rw "$cfg"
    '';
}
