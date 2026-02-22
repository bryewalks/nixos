{ lib, pkgs, ... }:

let
  themeBuilder = import ../themes/theme-builder.nix { inherit lib; };
  draculaTheme = themeBuilder.mkTheme { theme = "dracula"; };
  dracula = draculaTheme.hexNoHash;
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
    background_color=${dracula.background}
    table_columns=3

    ## Text ##
    font_size=18
    text_color=${dracula.foreground}
    text_outline_color=${dracula.selection}

    ## GPU ##
    gpu_text=GPU
    gpu_stats
    gpu_temp
    gpu_color=${dracula.green}
    gpu_load_change
    gpu_load_color=${dracula.green},${dracula.yellow},${dracula.red}

    ## CPU ##
    cpu_text=CPU
    cpu_stats
    cpu_temp
    cpu_color=${dracula.cyan}
    cpu_load_change
    cpu_load_color=${dracula.green},${dracula.yellow},${dracula.red}

    ## RAM ##
    ram
    ram_color=${dracula.magenta}

    ## FPS ##
    fps
    fps_color_change
    fps_color=${dracula.red},${dracula.yellow},${dracula.green}

    ## ENGINE ##
    engine_color=${dracula.purple}

    ## Frame timing ##
    frame_timing
    frametime_color=${dracula.green}

    arch
    fps_limit_method=early
    toggle_fps_limit=Shift_L+F1

    ## Wine ##
    wine
    wine_color=${dracula.purple}
  '';
}
