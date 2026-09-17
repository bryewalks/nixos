# Sops infrastructure only — per-user secrets live with their user
# (see modules/users/brye). defaultSopsFile is set per-host.
{ den, inputs, ... }:

{
  flake-file.inputs.sops-nix = {
    url = "github:Mic92/sops-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.workstation.includes = [ den.aspects.sops ];

  den.aspects.sops =
    { host, ... }:
    let
      sopsDir = "${host.persistRoot}/system/var/lib/sops";
    in
    {
      nixos = {
        imports = [ inputs.sops-nix.nixosModules.sops ];

        # TODO(sops-nix): drop once sops-nix bumps off buildGo125Module.
        # sops-install-secrets hardcodes it (pkgs/sops-install-secrets/default.nix
        # in Mic92/sops-nix), but nixpkgs removed it once Go 1.25 went EOL
        # (nixpkgs#563177, 2026-09-15). Restore it as an alias in the meantime.
        nixpkgs.overlays = [ (final: prev: { buildGo125Module = prev.buildGoModule; }) ];

        sops = {
          age.keyFile = "${sopsDir}/keys.txt";
        };

        systemd.tmpfiles.rules = [
          "d ${sopsDir} 0755 root root -"
        ];
      };

      provides.to-users.homeManager =
        { pkgs, ... }:
        {
          home.packages = [ pkgs.sops ];
          home.sessionVariables.SOPS_AGE_KEY_FILE = "${sopsDir}/keys.txt";
        };
    };
}
