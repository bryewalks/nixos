{ ... }:

{
  den.aspects.brye = {
    homeManager = {
      home.username = "brye";
      home.homeDirectory = "/home/brye";
      home.stateVersion = "25.11";
    };

    # The OS-level account, delivered to whichever host brye is on.
    # mySystem.isPasswordConfigured is declared in modules/base.
    provides.to-hosts.nixos =
      {
        config,
        lib,
        pkgs,
        ...
      }:
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
          initialPassword = lib.mkIf (!config.mySystem.isPasswordConfigured) "password";
          hashedPasswordFile = lib.mkIf config.mySystem.isPasswordConfigured config.sops.secrets.hashedPassword.path;
        };

        # brye's secrets (sops itself is wired by the sops aspect).
        sops.secrets.sshKey = {
          path = "/home/brye/.ssh/id_ed25519";
          owner = "brye";
          group = "users";
          mode = "0600";
        };

        sops.secrets.hashedPassword = lib.mkIf config.mySystem.isPasswordConfigured {
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
