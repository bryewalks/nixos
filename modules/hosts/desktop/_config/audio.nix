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

  # INFO: Mitigates USB autosuspend (not the main cause of mic drops, see below)
  # Disable USB autosuspend for AT2020USB-X
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="0909", ATTR{idProduct}=="0052", \
      TEST=="power/control", ATTR{power/control}="on"

    ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="0909", ATTR{idProduct}=="0052", \
      TEST=="power/autosuspend", ATTR{power/autosuspend}="-1"
  '';

  # INFO: Real fix for mic randomly dropping ("usb usb3-port2: disabled by hub
  # (EMI?), re-enabling..." in dmesg). The mic is the only device on the
  # ASMedia ASM2142/ASM3142 USB controller (07:00.0), which has a known Linux
  # bug where PCIe ASPM power-state transitions spuriously disable ports on
  # full-speed USB devices. Disabling ASPM system-wide avoids it.
  boot.kernelParams = [ "pcie_aspm=off" ];
}
