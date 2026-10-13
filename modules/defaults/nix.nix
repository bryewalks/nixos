{ den, ... }:

{
  den.default.includes = [ den.aspects.nix ];

  den.aspects.nix.nixos =
    {
      host,
      config,
      lib,
      ...
    }:
    lib.mkMerge [
      {
        nix.settings.experimental-features = [
          "nix-command"
          "flakes"
        ];
        nix.settings.auto-optimise-store = true;

        # nh's flake path is set by the user entity that owns the checkout
        # (modules/users/brye).
        programs.nh = {
          enable = true;
          # Auto garbage collect
          clean = {
            enable = true;
            dates = "daily";
            extraArgs = "--keep-since 3d --keep 5";
          };
        };

        # Required for nix flake operations
        programs.git.enable = true;
      }
      # Raises the GitHub API rate limit for `nix flake update`.
      # optionalAttrs, not mkIf: keeps sops.secrets.githubNetrc undeclared
      # (not just unset) on hosts without the sops aspect.
      (lib.optionalAttrs (host.nixGithubAuthConfigured or false) {
        nix.settings.netrc-file = config.sops.secrets.githubNetrc.path;
        sops.secrets.githubNetrc = {
          owner = "brye";
          mode = "0400";
        };
      })
    ];
}
