{ den, ... }:

{
  den.default.includes = [ den.aspects.networking ];

  den.aspects.networking.nixos =
    { host, ... }:
    {
      networking.hostName = host.hostName;
      networking.networkmanager.enable = true;
      time.timeZone = "America/Chicago";
    };
}
