# Tools available outside home-manager — root shells, TTYs, rescue work.
# Deliberate duplicates of user-level tooling.
{ den, ... }:

{
  den.default.includes = [ den.aspects.rescue ];

  den.aspects.rescue.nixos =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        neovim
        kitty
        lshw
      ];
    };
}
