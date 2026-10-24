{ den, ... }:

{
  den.aspects.workstation.includes = [ den.aspects.noctalia ];

  den.aspects.noctalia = {
    nixos.services.upower.enable = true;

    provides.to-users.homeManager =
      { config, pkgs, ... }:
      let
        wallpapers = "${config.xdg.dataHome}/wallpapers";
        palette = config.theme.palette;
        pill = fill: {
          capsule_fill = fill;
          capsule_foreground = palette.background;
        };
        darkPill = {
          capsule_fill = palette.background;
          capsule_foreground = palette.cyan;
        };
        otherTrayApps = [
          "dropbox"
          "udiskie"
          "steam"
          "Bitwarden_status_icon_1"
          "Discord_status_icon_1"
        ];
      in
      {
        systemd.user.services.noctalia.Service.ExecStartPre =
          "${pkgs.coreutils}/bin/rm -f %S/noctalia/settings.toml";

        programs.noctalia = {
          enable = true;
          systemd.enable = true;
          customPalettes.${config.theme.name}.dark = {
            mPrimary = palette.purple;
            mOnPrimary = palette.background;
            mSecondary = palette.magenta;
            mOnSecondary = palette.background;
            mTertiary = palette.cyan;
            mOnTertiary = palette.background;
            mError = palette.red;
            mOnError = palette.background;
            mSurface = palette.background;
            mOnSurface = palette.foreground;
            mSurfaceVariant = palette.lightBackground;
            mOnSurfaceVariant = palette.darkForeground;
            mOutline = palette.currentLine;
            mShadow = palette.background;
            mHover = palette.cyan;
            mOnHover = palette.background;
            terminal = {
              background = palette.background;
              foreground = palette.foreground;
              cursor = palette.foreground;
              cursorText = palette.background;
              selectionBg = palette.selection;
              selectionFg = palette.foreground;
              normal = {
                black = palette.selection;
                inherit (palette)
                  red
                  green
                  yellow
                  magenta
                  cyan
                  white
                  ;
                blue = palette.purple;
              };
              bright = {
                black = palette.currentLine;
                red = palette.brightRed;
                green = palette.brightGreen;
                yellow = palette.brightYellow;
                blue = palette.brightPurple;
                magenta = palette.brightMagenta;
                cyan = palette.brightCyan;
                white = palette.brightWhite;
              };
            };
          };

          settings = {
            shell = {
              font_family = config.stylix.fonts.monospace.name;
              panel = {
                transparency_mode = "solid";
                control_center_placement = "floating";
                session_placement = "floating";
                wallpaper_placement = "floating";
              };
            };

            theme = {
              source = "custom";
              custom_palette = config.theme.name;
            };

            bar.default = {
              start = [
                "nixdatifier"
                "launcher"
                "cpu"
                "ram"
                "screenshot"
                "tray"
                "network"
              ];
              center = [
                "workspaces"
              ];
              end = [
                "media"
                "notifications"
                "wallpaper"
                "bluetooth"
                "volume"
                "brightness"
                "battery"
                "weather"
                "clock"
                "session"
              ];
              background_opacity = 0.0;
              capsule = true;
              capsule_padding = 9.0;
              capsule_radius = 5;
              capsule_thickness = 0.74;
              compositor_blur = false;
              margin_ends = 0;
              padding = 6;
              radius = 0;
              shadow = false;
              scale = 1.2;
              thickness = 36;
            };

            weather.unit = "imperial";

            widget = {
              tray = darkPill // {
                hidden = [ "nixdatifier" ];
              };
              nixdatifier = darkPill // {
                type = "tray";
                hidden = otherTrayApps;
                scale = 1.6;
                capsule_radius = 2;
                capsule_padding = 5;
              };
              launcher = darkPill // {
                enabled = false;
              };
              cpu = pill palette.cyan // {
                stat = "cpu_temp";
                visualization = "none";
                label_min_width = 25;
              };
              ram = pill palette.magenta // {
                stat = "ram_pct";
                visualization = "none";
                label_min_width = 25;
              };
              screenshot = pill palette.currentLine // {
                glyph = "camera-filled";
              };
              brightness = pill palette.orange;
              control-center = {
                glyph = "home";
                icon_color = "tertiary";
              };
              notifications.hide_when_no_unread = true;
              clock = pill palette.green // {
                format = "{:%H:%M}";
                tooltip_format = "{:%A, %B %d, %Y}";
              };
              media = pill palette.lightPurple // {
                hide_when_no_media = true;
                show_progress = true;
                title_scroll = "on_hover";
              };
              wallpaper = pill palette.purple // {
                glyph = "photo";
              };
              network = pill "primary" // {
                show_label = false;
              };
              volume = pill palette.yellow;
              battery = pill palette.cyan;
              weather = pill palette.currentLine // {
                show_condition = false;
              };
              session = pill palette.red;
            };

            location.auto_locate = true;

            lockscreen_widgets.enabled = false;

            plugins.enabled = [ "noctalia/bitwarden" ];

            wallpaper = {
              directory = wallpapers;
              default.path = "${wallpapers}/lofi-wallpaper.png";
            };
          };
        };
      };
  };
}
