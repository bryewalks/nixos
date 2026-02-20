{ ... }:

{
  services.pipewire = {
    wireplumber = {
      enable = true;
      extraConfig."51-prefer-my-devices" = {
        "monitor.alsa.rules" = [
          # Audio Sinks
          {
            matches = [
              {
                "media.class" = "Audio/Sink";
                "alsa.card_name" = "FiiO K5 Pro";
              }
            ];
            actions.update-props = {
              "priority.session" = 3000;
              "priority.driver" = 3000;
            };
          }
          {
            matches = [
              {
                "media.class" = "Audio/Sink";
                "alsa.card_name" = "AT2020USB-X";
              }
            ];
            actions.update-props = {
              "priority.session" = 100;
              "priority.driver" = 100;
            };
          }

          # Audio Sources
          {
            matches = [
              {
                "media.class" = "Audio/Source";
                "alsa.card_name" = "AT2020USB-X";
              }
            ];
            actions.update-props = {
              "priority.session" = 3000;
              "priority.driver" = 3000;
            };
          }
          {
            matches = [
              {
                "media.class" = "Audio/Source";
                "alsa.card_name" = "HD Pro Webcam C920";
              }
            ];
            actions.update-props = {
              "priority.session" = 100;
              "priority.driver" = 100;
            };
          }
        ];
      };
    };
  };

  # INFO: Fixes issue where mic requires power cycling
  # Disable USB autosuspend for AT2020USB-X
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="0909", ATTR{idProduct}=="0052", \
      TEST=="power/control", ATTR{power/control}="on"

    ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="0909", ATTR{idProduct}=="0052", \
      TEST=="power/autosuspend", ATTR{power/autosuspend}="-1"
  '';
}
