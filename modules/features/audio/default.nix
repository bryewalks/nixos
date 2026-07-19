# System audio stack (pipewire).
{ den, ... }:

{
  den.aspects.features.includes = [ den.aspects.audio ];

  den.aspects.audio.nixos = {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
      jack.enable = true;
    };
  };
}
