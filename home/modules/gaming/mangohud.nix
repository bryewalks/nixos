{ pkgs, theme, ... }:

let
  palette = theme.hexNoHash;
in {
  home.packages = with pkgs; [
    mangohud
  ];

  programs.mangohud = {
    enable = true;
    enableSessionWide = true;
  };

  xdg.configFile."MangoHud/MangoHud.conf".text = ''
    legacy_layout=false
    position=top-right
    round_corners=10
    background_alpha=0.8
    background_color=${palette.background}
    table_columns=3

    ## Text ##
    font_size=18
    text_color=${palette.foreground}
    text_outline_color=${palette.selection}

    ## GPU ##
    gpu_text=GPU
    gpu_stats
    gpu_temp
    gpu_color=${palette.green}
    gpu_load_change
    gpu_load_color=${palette.green},${palette.yellow},${palette.red}

    ## CPU ##
    cpu_text=CPU
    cpu_stats
    cpu_temp
    cpu_color=${palette.cyan}
    cpu_load_change
    cpu_load_color=${palette.green},${palette.yellow},${palette.red}

    ## RAM ##
    ram
    ram_color=${palette.magenta}

    ## FPS ##
    fps
    fps_color_change
    fps_color=${palette.red},${palette.yellow},${palette.green}

    ## ENGINE ##
    engine_color=${palette.purple}

    ## Frame timing ##
    frame_timing
    frametime_color=${palette.green}

    arch
    fps_limit_method=early
    toggle_fps_limit=Shift_L+F1

    ## Wine ##
    wine
    wine_color=${palette.purple}
  '';
}
