# Razer mouse: OpenRazer driver, Polychromatic GUI, and persisted DPI/lighting.
{ den, ... }:

{
  den.aspects.gaming.includes = [ den.aspects.mouse ];

  den.aspects.mouse = {
    nixos = {
      hardware.openrazer = {
        enable = true;
        users = [ "brye" ];
      };
    };

    provides.to-users.homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.polychromatic ];

        xdg.configFile = {
          "openrazer/persistence.conf" = {
            force = true;
            text = ''
              [632519H33103858]
              dpi_x = 1600
              dpi_y = 1600
              poll_rate = 500
              backlight_active = True
              backlight_brightness = 75
              backlight_effect = static
              backlight_colors = 0 255 255 0 255 255 0 0 255
              backlight_speed = 1
              backlight_wave_dir = 2
              logo_active = True
              logo_brightness = 75
              logo_effect = spectrum
              logo_colors = 0 255 0 0 255 255 0 0 255
              logo_speed = 1
              logo_wave_dir = 1
              scroll_active = True
              scroll_brightness = 75
              scroll_effect = spectrum
              scroll_colors = 0 255 0 0 255 255 0 0 255
              scroll_speed = 1
              scroll_wave_dir = 1
            '';
          };

          # All stages set to 1600, so the physical DPI button is pseudo-disabled.
          "polychromatic/dpi/Razer Basilisk V3 35K.list" = {
            force = true;
            text = ''
              1600,1600
              1600,1600
              1600,1600
              1600,1600
              1600,1600
            '';
          };
        };
      };
  };
}
