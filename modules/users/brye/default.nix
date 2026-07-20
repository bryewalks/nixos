{ ... }:

{
  den.aspects.brye = {
    homeManager = {
      home.username = "brye";
      home.homeDirectory = "/home/brye";
      home.stateVersion = "25.11";
    };

    # The OS-level account, delivered to whichever host brye is on.
    # Flat-form class module: `host` is injected by den alongside the
    # module-system args; passwordConfigured is the host capability.
    provides.to-hosts.nixos =
      {
        host,
        config,
        lib,
        pkgs,
        ...
      }:
      let
        passwordConfigured = host.passwordConfigured or false;
      in
      {
        programs.zsh.enable = true;

        # brye owns the flake checkout nh operates on.
        programs.nh.flake = "/home/brye/nixos";

        users.users.brye = {
          isNormalUser = true;
          extraGroups = [
            "wheel"
            "networkmanager"
            "video"
            "audio"
            "input"
            "storage"
            "docker"
          ];
          shell = pkgs.zsh;
          initialPassword = lib.mkIf (!passwordConfigured) "password";
          hashedPasswordFile = lib.mkIf passwordConfigured config.sops.secrets.hashedPassword.path;
        };

        # brye's secrets (sops itself is wired by the sops aspect).
        sops.secrets.sshKey = {
          path = "/home/brye/.ssh/id_ed25519";
          owner = "brye";
          group = "users";
          mode = "0600";
        };

        sops.secrets.hashedPassword = lib.mkIf passwordConfigured {
          owner = "root";
          group = "root";
          mode = "0400";
          neededForUsers = true;
        };

        systemd.tmpfiles.rules = [
          "d /home/brye/.ssh 0700 brye users -"
        ];
      };
  };
}
