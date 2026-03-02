{ ... }:
let
  themeBuilder = import ../../../themes/theme-builder.nix { };
  draculaTheme = themeBuilder.mkTheme { theme = "dracula"; cssPath = ./style.css; };
  draculaCss = draculaTheme.resolvedCss;
  draculaPalette = draculaTheme.palette;
  draculaJson = draculaTheme.json;
  scriptsDir = toString ../../scripts;
  scriptPath = name: "${scriptsDir}/${name}";
in
{
  programs.waybar = {
    enable = true;
    settings = [
      {
        layer = "top";
        modules-left = [
          "custom/launcher"
          "cpu"
          "memory"
          "custom/media"
          "custom/snapshot"
          "custom/record"
          "tray"
        ];
        modules-center = [ "hyprland/workspaces" ];
        modules-right = [
          "cava"
          "custom/updates"
          "custom/wallpaper"
          "pulseaudio"
          "battery"
          "clock"
          "custom/weather"
          "custom/power"
        ];

        "custom/launcher" = {
          format = "";
          on-click = "rofi -show drun";
          tooltip = false;
          on-click-right = "killall rofi";
        };
        cpu = {
          interval = 15;
          format = " {}%";
          max-length = 10;
          on-click = "kitty btop";
        };
        memory = {
          interval = 30;
          format = " {}%";
          max-length = 10;
          on-click = "kitty btop";
        };
        "custom/media" = {
          interval = 30;
          format = "{icon} {}";
          return-type = "json";
          max-length = 20;
          format-icons = {
            spotify = " ";
            default = " ";
          };
          escape = true;
          exec = "${scriptPath "mediaplayer.py"} 2> /dev/null";
          on-click = "playerctl play-pause";
        };
        "custom/snapshot" = {
          format = "";
          tooltip = true;
          tooltip-format = "Monitor · Left   · SUPER + P\nWindow  · Middle · SUPER + CTRL + P\nRegion  · Right  · SUPER + SHIFT + P";
          on-click = scriptPath "screenshot-monitor.sh";
          on-click-middle = scriptPath "screenshot-window.sh";
          on-click-right = scriptPath "screenshot-region.sh";
        };
        "custom/record" = {
          interval = 0;
          signal = 8;
          exec = "pgrep -x wf-recorder > /dev/null && echo '●'";
          on-click = scriptPath "record-monitor.sh";
          on-click-middle = scriptPath "record-window.sh";
          on-click-right = scriptPath "record-region.sh";
        };
        tray = {
          icon-size = 18;
          spacing = 10;
        };
        network = {
          tooltip = false;
          format-wifi = "  {essid}";
          format-ethernet = "";
        };

        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          warp-on-scroll = false;
          format = "{icon}";
          format-icons = {
            urgent = "";
            active = "";
            default = "";
          };
        };
        "river/tags" = { num-tags = 6; };

        cava = {
          framerate = 120;
          autosens = 1;
          bars = 14;
          method = "pipewire";
          source = "auto";
          bar_delimiter = 0;
          input_delay = 2;
          sleep_timer = 2;
          hide_on_silence = true;
          format-icons = [
            "▁"
            "▂"
            "▃"
            "▄"
            "▅"
            "▆"
            "▇"
            "█"
          ];
          on-click-middle = scriptPath "winwrap.sh";
        };
        # "custom/updates" = {
        #   format = "{} Update(s)";
        #   exec = "checkupdates | wc -l";
        #   exec-if = "[[ $(checkupdates | wc -l) != 0 ]]";
        #   interval = 15;
        #   on-click = "kitty sudo pacman -Syu && notify-send ' 󰀦 System has been updated! '";
        # };
        "custom/wallpaper" = {
          tooltip = false;
          format = "";
          on-click = "waypaper";
          on-click-middle = scriptPath "hyprpicker-notify.sh";
          on-click-right = "waypaper --random";
        };
        backlight = {
          tooltip = false;
          format = " {}%";
          interval = 1;
          on-scroll-up = "light -A 5";
          on-scroll-down = "light -U 5";
        };
        pulseaudio = {
          tooltip = false;
          scroll-step = 5;
          format = "{icon} {volume}%";
          format-muted = " {volume}%";
          on-click = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
          on-click-middle = "systemctl --user restart pipewire";
          format-icons.default = [ "" "" "" ];
        };
        battery = {
          states = {
            good = 95;
            warning = 30;
            critical = 20;
          };
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-plugged = " {capacity}%";
          format-alt = "{time} {icon}";
          format-icons = [ "" "" "" "" "" ];
        };
        clock = {
          format = " {:%H:%M}";
          format-alt = "{:%a %b %d}";
          tooltip = true;
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "month";
            on-scroll = 1;
            format = {
              months = "<span color='${draculaPalette.purple}'><b>{}</b></span>";
              days = "<span color='${draculaPalette.foreground}'><b>{}</b></span>";
              weekdays = "<span color='${draculaPalette.cyan}'><b>{}</b></span>";
              today = "<span color='${draculaPalette.magenta}'><b>{}</b></span>";
            };
          };
          actions = {
            on-click-right = "mode";
            on-scroll-up = "shift_up";
            on-scroll-down = "shift_down";
          };
        };
        "custom/weather" = {
          format = "{}";
          tooltip = true;
          interval = 900;
          exec = "WEATHER_COLORS_JSON='${draculaJson}' ${scriptPath "weather.py"}";
          return-type = "json";
        };
        "custom/power" = {
          format = "";
          on-click = "wlogout";
          tooltip = false;
          on-click-middle = "shutdown -r now";
          on-click-right = "shutdown -P now";
        };
      }
    ];

    style = draculaCss;
  };
}
