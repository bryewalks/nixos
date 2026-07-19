{ den, ... }:

{
  den.aspects.base.nixos = {
    networking.networkmanager.enable = true;
    time.timeZone = "America/Chicago";
  };
}
