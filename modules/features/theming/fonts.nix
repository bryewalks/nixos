# System-level install of the theme font; stylix (default.nix) wires the same
# font per-user.
{ den, ... }:

{
  den.aspects.theming.nixos =
    { pkgs, ... }:
    {
      fonts.packages = with pkgs; [ nerd-fonts.caskaydia-cove ];
    };
}
