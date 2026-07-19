{ den, ... }:

{
  den.default.includes = [ den.aspects.networking ];

  den.aspects.networking.nixos = {
    networking.networkmanager.enable = true;
    time.timeZone = "America/Chicago";
  };
}
